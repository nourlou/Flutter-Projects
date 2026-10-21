import 'package:flutter/material.dart';

import '../models/formation.dart';

class FormationCard extends StatelessWidget {
  final Formation formation;
  final int modulesChoisis;
  final VoidCallback onTap;

  const FormationCard({
    super.key,
    required this.formation,
    required this.onTap,
    this.modulesChoisis = 0,
  });

  @override
  Widget build(BuildContext context) {
    final texte = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: formation.couleur.withAlpha(38),
                      child: Icon(formation.icone, size: 48, color: formation.couleur),
                    ),
                  ),
                  if (modulesChoisis > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: formation.couleur,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '✓ $modulesChoisis',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formation.titre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: texte.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${formation.niveau} • ${formation.dureeTotale} h',
                    style: texte.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatPrix(formation.prixTotal),
                    style: texte.labelLarge?.copyWith(color: formation.couleur),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
