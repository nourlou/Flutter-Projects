import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import 'step_one_screen.dart';

class SummaryScreen extends StatefulWidget {
  final UserProfile profil;

  const SummaryScreen({
    super.key,
    required this.profil,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _conditionsKey = GlobalKey<FormFieldState<bool>>();

  bool _conditionsAcceptees = false;

  Widget _ligne(
    IconData icone,
    String titre,
    String valeur,
  ) {
    return ListTile(
      leading: Icon(
        icone,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(titre),
      subtitle: Text(
        valeur.isEmpty ? 'Non renseigné' : valeur,
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Future<void> _reinitialiser() async {
    final confirmer = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Réinitialiser le formulaire ?'),
        content: const Text(
          'Toutes les informations saisies seront effacées.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, false);
            },
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext, true);
            },
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 48,
        ),
        title: const Text('Inscription réussie !'),
        content: Text(
          'Bienvenue ${widget.profil.prenom} ! '
          'Votre profil a été créé.',
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const StepOneScreen(),
                ),
                (route) => false,
              );
            },
            child: const Text('Terminer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profil = widget.profil;

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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Carte Identité
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Identité',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      const SizedBox(height: 8),
                      _ligne(
                        Icons.person_outline,
                        'Nom complet',
                        profil.nomComplet,
                      ),
                      _ligne(
                        Icons.email_outlined,
                        'E-mail',
                        profil.email,
                      ),
                      _ligne(
                        Icons.lock_outline,
                        'Mot de passe',
                        '••••••••',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Carte Profil professionnel
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profil professionnel',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      const SizedBox(height: 8),
                      _ligne(
                        Icons.work_outline,
                        'Profession',
                        profil.profession,
                      ),
                      _ligne(
                        Icons.timeline,
                        "Années d'expérience",
                        '${profil.experience} an(s)',
                      ),
                      _ligne(
                        Icons.euro,
                        'TJM',
                        '${profil.tjm.toStringAsFixed(2)} €',
                      ),
                      _ligne(
                        Icons.description_outlined,
                        'Biographie',
                        profil.biographie,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Acceptation obligatoire des conditions
              FormField<bool>(
                key: _conditionsKey,
                initialValue: false,
                validator: (value) {
                  if (value != true) {
                    return "Vous devez accepter les conditions "
                        "d’utilisation";
                  }
                  return null;
                },
                builder: (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity:
                            ListTileControlAffinity.leading,
                        value: _conditionsAcceptees,
                        title: const Text(
                          "J'accepte les conditions d'utilisation",
                        ),
                        onChanged: (value) {
                          setState(() {
                            _conditionsAcceptees = value ?? false;
                          });

                          state.didChange(value);
                        },
                      ),
                      if (state.errorText != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            state.errorText!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .error,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              FilledButton.icon(
                onPressed: _confirmer,
                icon: const Icon(Icons.check),
                label: const Text(
                  'Confirmer et créer le compte',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}