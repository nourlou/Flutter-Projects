import 'package:flutter/foundation.dart';

import 'formation.dart';

class ElementPanier {
  final Formation formation;
  final Module module;

  const ElementPanier(this.formation, this.module);

  /// Clé unique, utilisée par Dismissible.
  String get cle => module.id;
}

class Panier extends ChangeNotifier {
  final List<ElementPanier> _elements = [];

  List<ElementPanier> get elements => List.unmodifiable(_elements);
  int get nombre => _elements.length;
  bool get estVide => _elements.isEmpty;

  int get totalHeures => _elements.fold<int>(0, (s, e) => s + e.module.heures);
  double get totalPrix => _elements.fold<double>(0, (s, e) => s + e.module.prix);

  bool contient(Module m) => _elements.any((e) => e.module.id == m.id);

  /// Identifiants des modules d'une formation déjà présents dans le panier.
  Set<String> modulesDe(Formation f) => _elements
      .where((e) => e.formation.id == f.id)
      .map((e) => e.module.id)
      .toSet();

  /// Remplace les modules choisis pour une formation.
  void definirModules(Formation f, Set<String> idsModules) {
    _elements.removeWhere((e) => e.formation.id == f.id);
    for (final m in f.modules) {
      if (idsModules.contains(m.id)) _elements.add(ElementPanier(f, m));
    }
    notifyListeners();
  }

  /// Retire un élément et renvoie sa position (pour pouvoir l'annuler).
  int retirer(ElementPanier e) {
    final index = _elements.indexWhere((x) => x.cle == e.cle);
    if (index >= 0) {
      _elements.removeAt(index);
      notifyListeners();
    }
    return index;
  }

  /// Réinsère un élément (bouton « Annuler » du SnackBar).
  void inserer(int index, ElementPanier e) {
    if (index < 0 || contient(e.module)) return;
    final position = index > _elements.length ? _elements.length : index;
    _elements.insert(position, e);
    notifyListeners();
  }

  void vider() {
    _elements.clear();
    notifyListeners();
  }
}
