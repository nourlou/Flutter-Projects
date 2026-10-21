import 'package:flutter_test/flutter_test.dart';
import 'package:tp_catalogue/data/catalogue.dart';
import 'package:tp_catalogue/models/panier.dart';

void main() {
  final flutter = catalogue.firstWhere((f) => f.id == 'flutter');
  final web = catalogue.firstWhere((f) => f.id == 'web');

  test('un panier neuf est vide', () {
    final p = Panier();
    expect(p.estVide, isTrue);
    expect(p.totalPrix, 0);
  });

  test('definirModules ajoute les modules choisis', () {
    final p = Panier()..definirModules(flutter, {'flutter-1', 'flutter-3'});
    expect(p.nombre, 2);
    expect(p.totalHeures, 12 + 14);
    expect(p.totalPrix, 120 + 140);
  });

  test('definirModules remplace la sélection précédente', () {
    final p = Panier()
      ..definirModules(flutter, {'flutter-1', 'flutter-2'})
      ..definirModules(web, {'web-1'})
      ..definirModules(flutter, {'flutter-4'});
    expect(p.modulesDe(flutter), {'flutter-4'});
    expect(p.nombre, 2);
  });

  test('retirer puis inserer restaure la position', () {
    final p = Panier()..definirModules(flutter, {'flutter-1', 'flutter-2', 'flutter-3'});
    final e = p.elements[1];
    final index = p.retirer(e);
    expect(p.nombre, 2);
    p.inserer(index, e);
    expect(p.elements[1].cle, 'flutter-2');
  });

  test('notifie les écouteurs à chaque modification', () {
    final p = Panier();
    var appels = 0;
    p.addListener(() => appels++);
    p.definirModules(web, {'web-1'});
    p.vider();
    expect(appels, 2);
  });
}
