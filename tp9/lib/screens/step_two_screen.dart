
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_profile.dart';
import '../utils/validators.dart';
import 'summary_screen.dart';

class StepTwoScreen extends StatefulWidget {
  final UserProfile profil;

  const StepTwoScreen({super.key, required this.profil});

  @override
  State<StepTwoScreen> createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profession = TextEditingController();
  final _experience = TextEditingController();
  final _tjm = TextEditingController();
  final _bio = TextEditingController();

  @override
  void dispose() {
    _profession.dispose();
    _experience.dispose();
    _tjm.dispose();
    _bio.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;

    final profil = widget.profil.copyWith(
      profession: _profession.text.trim(),
      experience: int.parse(_experience.text.trim()),
      tjm: double.parse(
        _tjm.text.trim().replaceAll(',', '.'),
      ),
      biographie: _bio.text.trim(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SummaryScreen(profil: profil),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Professionnel – Étape 2/3'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: 2 / 3,
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
              'Votre profil professionnel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: _profession,
              decoration: const InputDecoration(
                labelText: 'Profession',
                prefixIcon: Icon(Icons.work_outline),
              ),
              validator: Validators.profession,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _experience,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: "Années d'expérience",
                prefixIcon: Icon(Icons.calendar_month_outlined),
              ),
              validator: Validators.experience,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _tjm,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9,.]'),
                ),
              ],
              decoration: const InputDecoration(
                labelText: 'TJM',
                prefixIcon: Icon(Icons.euro),
                suffixText: '€',
              ),
              validator: Validators.tjm,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _bio,
              maxLength: 300,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Biographie (facultative)',
                hintText: 'Présentez votre parcours...',
                prefixIcon: Icon(Icons.description_outlined),
                alignLabelWithHint: true,
              ),
              validator: Validators.biographie,
            ),
            const SizedBox(height: 16),

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
