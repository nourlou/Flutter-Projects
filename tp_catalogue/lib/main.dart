import 'package:flutter/material.dart';

import 'models/panier.dart';
import 'screens/catalogue_screen.dart';

void main() => runApp(CatalogueApp());

class CatalogueApp extends StatelessWidget {
  CatalogueApp({super.key});

  /// Instance unique partagée par les trois écrans.
  final Panier panier = Panier();

  // Valeurs reprises des styles Figma
  static const Color primary = Color(0xFF3F51B5);
  static const Color background = Color(0xFFF5F6FA);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalogue de formations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            shape: const StadiumBorder(),
          ),
        ),
      ),
      home: CatalogueScreen(panier: panier),
    );
  }
}
