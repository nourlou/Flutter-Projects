
class Validators {
  static String? nom(String? value) {
    final v = value?.trim() ?? '';

    if (v.isEmpty) return 'Le nom est obligatoire';
    if (v.length < 2) {
      return 'Le nom doit contenir au moins 2 caractères';
    }

    final regex = RegExp(
      r"^[\p{L}]+(?:[ '\u2019-][\p{L}]+)*$",
      unicode: true,
    );

    if (!regex.hasMatch(v)) {
      return 'Le nom ne doit contenir que des lettres';
    }
    return null;
  }

  static String? prenom(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Le prénom est obligatoire';
    if (v.length < 2) {
      return 'Le prénom doit contenir au moins 2 caractères';
    }

    final regex = RegExp(
      r"^[\p{L}]+(?:[ '\u2019-][\p{L}]+)*$",
      unicode: true,
    );

    if (!regex.hasMatch(v)) {
      return 'Le prénom ne doit contenir que des lettres';
    }
    return null;
  }

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return "L'e-mail est obligatoire";

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)) {
      return 'Format attendu : nom@domaine.com';
    }
    return null;
  }

  static String? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Le mot de passe est obligatoire';
    if (v.length < 8) return 'Au moins 8 caractères';
    if (!RegExp(r'[A-Z]').hasMatch(v)) {
      return 'Au moins une lettre majuscule';
    }
    if (!RegExp(r'[0-9]').hasMatch(v)) {
      return 'Au moins un chiffre';
    }
    return null;
  }

  static String? confirmation(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer le mot de passe';
    }
    if (value != password) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  static String? profession(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'La profession est obligatoire';
    if (v.length < 2) {
      return 'Au moins 2 caractères sont nécessaires';
    }
    return null;
  }

  static String? experience(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return "L'expérience est obligatoire";

    final n = int.tryParse(v);
    if (n == null || n < 0 || n > 50) {
      return 'Valeur comprise entre 0 et 50';
    }
    return null;
  }

  static String? tjm(String? value) {
    final v = (value ?? '').trim().replaceAll(',', '.');
    if (v.isEmpty) return 'Le TJM est obligatoire';

    final n = double.tryParse(v);
    if (n == null || !n.isFinite || n < 50 || n > 3000) {
      return 'Le TJM doit être compris entre 50 € et 3000 €';
    }
    return null;
  }

  static String? biographie(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null;

    if (v.length < 20) {
      return 'Au moins 20 caractères, ou laissez vide';
    }
    if (v.length > 300) {
      return 'Maximum 300 caractères';
    }
    return null;
  }
}
