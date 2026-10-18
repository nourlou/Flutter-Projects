
import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import 'step_one_screen.dart';

class SummaryScreen extends StatefulWidget {
  final UserProfile profil;

  const SummaryScreen({super.key, required this.profil});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _conditionsAcceptees = false;

  Widget _infoCard(String titre, List<Widget> lignes) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titre,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ...lignes,
          ],
        ),
      ),
    );
  }

  Widget _ligne(String label, String valeur, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: const Color(0xFF00A8CC)),
      title: Text(label),
      subtitle: Text(valeur.isEmpty ? 'Non renseigné' : valeur),
    );
  }

  Future<void> _reinitialiser() async {
    final confirmer = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Réinitialiser'),
        content: const Text(
          'Voulez-vous vraiment effacer le profil et recommencer ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Réinitialiser'),
          ),
        ],
      ),
    );

    if (confirmer == true && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const StepOneScreen(),
        ),
        (route) => false,
      );
    }
  }

  Future<void> _confirmer() async {
    if (!_formKey.currentState!.validate()) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: Color(0xFF00A8CC),
          size: 56,
        ),
        title: const Text('Inscription réussie !'),
        content: const Text(
          'Votre profil a été validé avec succès.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Terminer'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const StepOneScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profil;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Récapitulatif de votre profil'),
        actions: [
          IconButton(
            tooltip: 'Réinitialiser',
            icon: const Icon(Icons.refresh),
            onPressed: _reinitialiser,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _infoCard('Identité', [
              _ligne('Nom', p.nom, Icons.person_outline),
              _ligne('Prénom', p.prenom, Icons.person_outline),
              _ligne('E-mail', p.email, Icons.email_outlined),
              _ligne(
                'Mot de passe',
                '••••••••',
                Icons.lock_outline,
              ),
            ]),
            const SizedBox(height: 12),

            _infoCard('Profil professionnel', [
              _ligne('Profession', p.profession, Icons.work_outline),
              _ligne(
                "Années d'expérience",
                p.experience?.toString() ?? '',
                Icons.calendar_month_outlined,
              ),
              _ligne(
                'TJM',
                p.tjm == null ? '' : '${p.tjm} €',
                Icons.euro,
              ),
              _ligne(
                'Biographie',
                p.biographie,
                Icons.description_outlined,
              ),
            ]),
            const SizedBox(height: 12),

            FormField<bool>(
              initialValue: false,
              validator: (value) {
                if (value != true) {
                  return "Vous devez accepter les conditions d'utilisation";
                }
                return null;
              },
              builder: (state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: state.value ?? false,
                    title: const Text(
                      "J'accepte les conditions d'utilisation",
                    ),
                    onChanged: (value) {
                      state.didChange(value ?? false);
                    },
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        state.errorText!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 48,
              child: FilledButton(
                onPressed: _confirmer,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF00A8CC),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                child: const Text('Confirmer et créer le compte'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
