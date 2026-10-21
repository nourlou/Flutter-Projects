import 'package:flutter/material.dart';

/// Affiche un prix en dinars tunisiens.
String formatPrix(double prix) => '${prix.toStringAsFixed(0)} DT';

class Module {
  final String id;
  final String titre;
  final int heures;
  final double prix;

  const Module({
    required this.id,
    required this.titre,
    required this.heures,
    required this.prix,
  });
}

class Formation {
  final String id;
  final String titre;
  final String niveau;
  final String description;
  final IconData icone;
  final Color couleur;
  final List<Module> modules;

  const Formation({
    required this.id,
    required this.titre,
    required this.niveau,
    required this.description,
    required this.icone,
    required this.couleur,
    required this.modules,
  });

  int get dureeTotale => modules.fold<int>(0, (somme, m) => somme + m.heures);

  double get prixTotal => modules.fold<double>(0, (somme, m) => somme + m.prix);
}
