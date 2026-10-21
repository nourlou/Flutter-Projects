import 'package:flutter/material.dart';

import '../models/formation.dart';
import '../models/panier.dart';

class DetailFormationScreen extends StatefulWidget {
  final Formation formation;
  final Panier panier;

  const DetailFormationScreen({
    super.key,
    required this.formation,
    required this.panier,
  });

  @override
  State<DetailFormationScreen> createState() => _DetailFormationScreenState();
}

class _DetailFormationScreenState extends State<DetailFormationScreen> {
  late final Set<String> _selection;

  Formation get f => widget.formation;

  @override
  void initState() {
    super.initState();
    _selection = widget.panier.modulesDe(f);
  }

  /// true = tous cochés, false = aucun, null = certains (état indéterminé)
  bool? get _etatTout {
    if (_selection.isEmpty) return false;
    if (_selection.length == f.modules.length) return true;
    return null;
  }

  double get _sousTotal => f.modules
      .where((m) => _selection.contains(m.id))
      .fold<double>(0, (s, m) => s + m.prix);

  void _basculerTout() {
    setState(() {
      if (_etatTout == true) {
        _selection.clear();
      } else {
        _selection.addAll(f.modules.map((m) => m.id));
      }
    });
  }

  void _basculerModule(Module m, bool? coche) {
    setState(() {
      if (coche == true) {
        _selection.add(m.id);
      } else {
        _selection.remove(m.id);
      }
    });
  }

  void _valider() {
    final messenger = ScaffoldMessenger.of(context);
    widget.panier.definirModules(f, _selection);
    Navigator.pop(context);
    messenger.showSnackBar(
      SnackBar(
        content: Text(_selection.isEmpty
            ? '« ${f.titre} » retirée du panier'
            : '${_selection.length} module(s) de « ${f.titre} » dans le panier'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final texte = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(f.titre, overflow: TextOverflow.ellipsis)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: f.couleur.withAlpha(38),
                        child: Icon(f.icone, color: f.couleur, size: 30),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(f.titre, style: texte.titleMedium)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(f.description),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(avatar: const Icon(Icons.signal_cellular_alt, size: 18), label: Text(f.niveau)),
                      Chip(avatar: const Icon(Icons.schedule, size: 18), label: Text('${f.dureeTotale} h')),
                      Chip(avatar: const Icon(Icons.view_module, size: 18), label: Text('${f.modules.length} modules')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Modules', style: texte.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                CheckboxListTile(
                  tristate: true,
                  value: _etatTout,
                  onChanged: (_) => _basculerTout(),
                  title: const Text('Tout sélectionner'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const Divider(height: 1),
                ...f.modules.map(
                  (m) => CheckboxListTile(
                    value: _selection.contains(m.id),
                    onChanged: (v) => _basculerModule(m, v),
                    title: Text(m.titre),
                    subtitle: Text('${m.heures} h • ${formatPrix(m.prix)}'),
                    secondary: Icon(Icons.menu_book_outlined, color: f.couleur),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sous-total'),
                  Text(formatPrix(_sousTotal), style: texte.titleMedium),
                ],
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: _valider,
                icon: const Icon(Icons.add_shopping_cart),
                label: Text('Mettre à jour le panier (${_selection.length})'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
