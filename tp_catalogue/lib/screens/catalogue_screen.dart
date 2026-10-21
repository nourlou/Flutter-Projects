import 'package:flutter/material.dart';

import '../data/catalogue.dart';
import '../models/formation.dart';
import '../models/panier.dart';
import '../widgets/formation_card.dart';
import 'detail_formation_screen.dart';
import 'panier_screen.dart';

class CatalogueScreen extends StatefulWidget {
  final Panier panier;

  const CatalogueScreen({super.key, required this.panier});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  bool _enGrille = true;
  String _recherche = '';

  List<Formation> get _formationsFiltrees {
    final q = _recherche.trim().toLowerCase();
    if (q.isEmpty) return catalogue;
    return catalogue
        .where((f) =>
            f.titre.toLowerCase().contains(q) || f.niveau.toLowerCase().contains(q))
        .toList();
  }

  void _ouvrirDetail(Formation f) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailFormationScreen(formation: f, panier: widget.panier),
      ),
    );
  }

  void _ouvrirPanier() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PanierScreen(panier: widget.panier)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue des formations'),
        actions: [
          IconButton(
            tooltip: _enGrille ? 'Afficher en liste' : 'Afficher en grille',
            icon: Icon(_enGrille ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _enGrille = !_enGrille),
          ),
          ListenableBuilder(
            listenable: widget.panier,
            builder: (context, _) => IconButton(
              tooltip: 'Mon panier',
              onPressed: _ouvrirPanier,
              icon: Badge(
                isLabelVisible: widget.panier.nombre > 0,
                label: Text('${widget.panier.nombre}'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Rechercher une formation…',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => _recherche = v),
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: widget.panier,
              builder: (context, _) {
                final formations = _formationsFiltrees;
                if (formations.isEmpty) return const _AucunResultat();
                return _enGrille ? _grille(formations) : _liste(formations);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _grille(List<Formation> formations) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75, // 167 / 223 comme dans Figma
      ),
      itemCount: formations.length,
      itemBuilder: (context, index) {
        final f = formations[index];
        return FormationCard(
          formation: f,
          modulesChoisis: widget.panier.modulesDe(f).length,
          onTap: () => _ouvrirDetail(f),
        );
      },
    );
  }

  Widget _liste(List<Formation> formations) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: formations.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final f = formations[index];
        final choisis = widget.panier.modulesDe(f).length;
        return Card(
          elevation: 1,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: f.couleur.withAlpha(38),
              child: Icon(f.icone, color: f.couleur),
            ),
            title: Text(f.titre),
            subtitle: Text(
              '${f.niveau} • ${f.modules.length} modules • ${f.dureeTotale} h'
              '${choisis > 0 ? '\n✓ $choisis module(s) choisi(s)' : ''}',
            ),
            isThreeLine: choisis > 0,
            trailing: Text(formatPrix(f.prixTotal)),
            onTap: () => _ouvrirDetail(f),
          ),
        );
      },
    );
  }
}

class _AucunResultat extends StatelessWidget {
  const _AucunResultat();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 8),
          Text('Aucune formation ne correspond à votre recherche'),
        ],
      ),
    );
  }
}
