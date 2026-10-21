import 'package:flutter/material.dart';

import '../models/formation.dart';

const List<Formation> catalogue = [
  Formation(
    id: 'flutter',
    titre: 'Développement mobile avec Flutter',
    niveau: 'Intermédiaire',
    description: 'Créez des applications Android et iOS à partir d\'un seul code Dart.',
    icone: Icons.phone_android,
    couleur: Color(0xFF0288D1),
    modules: [
      Module(id: 'flutter-1', titre: 'Les bases de Dart', heures: 12, prix: 120),
      Module(id: 'flutter-2', titre: 'Widgets et mise en page', heures: 16, prix: 160),
      Module(id: 'flutter-3', titre: 'Listes, grilles et navigation', heures: 14, prix: 140),
      Module(id: 'flutter-4', titre: 'Formulaires et validation', heures: 10, prix: 100),
    ],
  ),
  Formation(
    id: 'web',
    titre: 'Intégration web HTML / CSS',
    niveau: 'Débutant',
    description: 'Structurez et mettez en forme des pages web modernes et responsives.',
    icone: Icons.language,
    couleur: Color(0xFFE64A19),
    modules: [
      Module(id: 'web-1', titre: 'Structure HTML5', heures: 8, prix: 70),
      Module(id: 'web-2', titre: 'CSS et Flexbox', heures: 12, prix: 100),
      Module(id: 'web-3', titre: 'CSS Grid et responsive', heures: 10, prix: 90),
    ],
  ),
  Formation(
    id: 'php',
    titre: 'Applications web PHP MVC',
    niveau: 'Avancé',
    description: 'Concevez une application web structurée en MVC avec PHP et MySQL.',
    icone: Icons.code,
    couleur: Color(0xFF5E35B1),
    modules: [
      Module(id: 'php-1', titre: 'PHP orienté objet', heures: 14, prix: 140),
      Module(id: 'php-2', titre: 'Le modèle MVC', heures: 12, prix: 120),
      Module(id: 'php-3', titre: 'PDO et MySQL', heures: 10, prix: 100),
      Module(id: 'php-4', titre: 'Sécurité des formulaires', heures: 8, prix: 80),
    ],
  ),
  Formation(
    id: 'bdd',
    titre: 'Bases de données SQL',
    niveau: 'Débutant',
    description: 'Modélisez des données et écrivez des requêtes SQL efficaces.',
    icone: Icons.storage,
    couleur: Color(0xFF2E7D32),
    modules: [
      Module(id: 'bdd-1', titre: 'Modélisation MCD / MLD', heures: 10, prix: 90),
      Module(id: 'bdd-2', titre: 'Requêtes SELECT et jointures', heures: 12, prix: 110),
      Module(id: 'bdd-3', titre: 'Procédures et triggers', heures: 8, prix: 80),
    ],
  ),
  Formation(
    id: 'design',
    titre: 'Maquettage UI avec Figma',
    niveau: 'Débutant',
    description: 'Concevez des interfaces claires avec des composants et des prototypes.',
    icone: Icons.design_services,
    couleur: Color(0xFFC2185B),
    modules: [
      Module(id: 'design-1', titre: 'Frames, grilles et styles', heures: 6, prix: 60),
      Module(id: 'design-2', titre: 'Composants et variantes', heures: 8, prix: 80),
      Module(id: 'design-3', titre: 'Prototypage', heures: 6, prix: 60),
    ],
  ),
  Formation(
    id: 'reseau',
    titre: 'Administration réseau',
    niveau: 'Intermédiaire',
    description: 'Configurez et sécurisez un réseau local d\'entreprise.',
    icone: Icons.router,
    couleur: Color(0xFFF9A825),
    modules: [
      Module(id: 'reseau-1', titre: 'Adressage IP et sous-réseaux', heures: 10, prix: 100),
      Module(id: 'reseau-2', titre: 'Routage et VLAN', heures: 12, prix: 120),
      Module(id: 'reseau-3', titre: 'Pare-feu et VPN', heures: 10, prix: 110),
    ],
  ),
];
