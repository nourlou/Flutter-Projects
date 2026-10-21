import 'package:flutter/material.dart';

import '../models/formation.dart';
import '../models/panier.dart';

class PanierScreen extends StatelessWidget {
  final Panier panier;

  const PanierScreen({super.key, required this.panier});

  void _retirer(BuildContext context, ElementPanier e) {
    final index = panier.retirer(e);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('« ${e.module.titre} » retiré'),
          action: SnackBarAction(
            label: 'Annuler',
            onPressed: () => panier.inserer(index, e),
          ),
        ),
      );
  }

  Future<void> _vider(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Vider le panier ?'),
        content: const Text('Tous les modules sélectionnés seront retirés.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annuler')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Vider')),
        ],
      ),
    );
    if (ok == true) panier.vider();
  }

  Future<void> _valider(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        title: const Text('Inscription enregistrée'),
        content: Text(
          '${panier.nombre} module(s) • ${panier.totalHeures} h\n'
          'Montant : ${formatPrix(panier.totalPrix)}',
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Terminer')),
        ],
      ),
    );
    panier.vider();
    if (context.mounted) Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon panier'),
        actions: [
          ListenableBuilder(
            listenable: panier,
            builder: (context, _) => IconButton(
              tooltip: 'Vider le panier',
              icon: const Icon(Icons.delete_outline),
              onPressed: panier.estVide ? null : () => _vider(context),
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: panier,
        builder: (context, _) {
          if (panier.estVide) return const _PanierVide();
          final elements = panier.elements;

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: elements.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final e = elements[index];
                    return Dismissible(
                      key: ValueKey(e.cle),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Theme.of(context).colorScheme.error,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => _retirer(context, e),
                      child: ListTile(
                        tileColor: Colors.white,
                        leading: CircleAvatar(
                          backgroundColor: e.formation.couleur.withAlpha(38),
                          child: Icon(e.formation.icone, color: e.formation.couleur),
                        ),
                        title: Text(e.module.titre),
                        subtitle: Text('${e.formation.titre} • ${e.module.heures} h'),
                        trailing: Text(formatPrix(e.module.prix)),
                      ),
                    );
                  },
                ),
              ),
              _BarreTotal(panier: panier, onValider: () => _valider(context)),
            ],
          );
        },
      ),
    );
  }
}

class _BarreTotal extends StatelessWidget {
  final Panier panier;
  final VoidCallback onValider;

  const _BarreTotal({required this.panier, required this.onValider});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total (${panier.nombre} modules, ${panier.totalHeures} h)'),
                  Text(
                    formatPrix(panier.totalPrix),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: onValider,
                icon: const Icon(Icons.check),
                label: const Text("Valider l'inscription"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PanierVide extends StatelessWidget {
  const _PanierVide();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.remove_shopping_cart_outlined, size: 72, color: Colors.grey),
          const SizedBox(height: 12),
          const Text('Votre panier est vide'),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Parcourir le catalogue'),
          ),
        ],
      ),
    );
  }
}
