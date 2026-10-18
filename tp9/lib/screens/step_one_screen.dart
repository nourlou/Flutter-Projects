
import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../utils/validators.dart';
import 'step_two_screen.dart';

class StepOneScreen extends StatefulWidget {
  const StepOneScreen({super.key});

  @override
  State<StepOneScreen> createState() => _StepOneScreenState();
}

class _StepOneScreenState extends State<StepOneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _confirmationKey = GlobalKey<FormFieldState<String>>();

  final _nom = TextEditingController();
  final _prenom = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmation = false;

  @override
  void dispose() {
    _nom.dispose();
    _prenom.dispose();
    _email.dispose();
    _password.dispose();
    _confirmation.dispose();
    super.dispose();
  }

  Widget _field({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    Widget? suffix,
    bool obscure = false,
    TextInputType? keyboard,
    Key? fieldKey,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      key: fieldKey,
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      textInputAction: TextInputAction.next,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
      ),
    );
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;

    final profil = UserProfile(
      nom: _nom.text.trim(),
      prenom: _prenom.text.trim(),
      email: _email.text.trim(),
      password: _password.text,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StepTwoScreen(profil: profil),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Inscription – Étape 1/3',
          style: TextStyle(fontSize: 20),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: 1 / 3,
            minHeight: 4,
            backgroundColor: Color(0xFFE3EDF0),
            color: Color(0xFF00A8CC),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Informations personnelles',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            _field(
              label: 'Nom',
              icon: Icons.person_outline,
              controller: _nom,
              validator: Validators.nom,
            ),
            const SizedBox(height: 16),

            _field(
              label: 'Prénom',
              icon: Icons.person_outline,
              controller: _prenom,
              validator: Validators.prenom,
            ),
            const SizedBox(height: 16),

            _field(
              label: 'E-mail',
              icon: Icons.email_outlined,
              controller: _email,
              keyboard: TextInputType.emailAddress,
              validator: Validators.email,
            ),
            const SizedBox(height: 16),

            _field(
              label: 'Mot de passe',
              icon: Icons.lock_outline,
              controller: _password,
              obscure: !_showPassword,
              validator: Validators.password,
              suffix: IconButton(
                icon: Icon(
                  _showPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() => _showPassword = !_showPassword);
                },
              ),
              onChanged: (_) {
                _confirmationKey.currentState?.validate();
              },
            ),
            const SizedBox(height: 16),

            _field(
              label: 'Confirmation du mot de passe',
              icon: Icons.lock_outline,
              controller: _confirmation,
              obscure: !_showConfirmation,
              fieldKey: _confirmationKey,
              validator: (value) =>
                  Validators.confirmation(value, _password.text),
              suffix: IconButton(
                icon: Icon(
                  _showConfirmation
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _showConfirmation = !_showConfirmation;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 48,
              child: FilledButton(
                onPressed: _next,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF00A8CC),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                child: const Text('Suivant'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
