
import 'package:flutter_test/flutter_test.dart';
import 'package:tp9/utils/validators.dart';

void main() {
  group('Validation du nom', () {
    test('Un nom valide est accepté', () {
      expect(Validators.nom('Ben Ali'), isNull);
    });

    test('Un nom trop court est refusé', () {
      expect(
        Validators.nom('A'),
        'Le nom doit contenir au moins 2 caractères',
      );
    });

    test('Un nom vide est refusé', () {
      expect(
        Validators.nom('  '),
        'Le nom est obligatoire',
      );
    });

    test('Les chiffres sont refusés', () {
      expect(
        Validators.nom('Ben3'),
        'Le nom ne doit contenir que des lettres',
      );
    });
  });

  group('Validation de l’e-mail', () {
    test('Un e-mail valide est accepté', () {
      expect(Validators.email('ali@gmail.com'), isNull);
    });

    test('Un e-mail invalide est refusé', () {
      expect(Validators.email('ali@gmail'), isNotNull);
    });
  });

  group('Validation du mot de passe', () {
    test('Un mot de passe valide est accepté', () {
      expect(Validators.password('Bonjour123'), isNull);
    });

    test('Une majuscule est obligatoire', () {
      expect(
        Validators.password('bonjour12'),
        'Au moins une lettre majuscule',
      );
    });

    test('Huit caractères minimum', () {
      expect(
        Validators.password('Ab1'),
        'Au moins 8 caractères',
      );
    });
  });

  group('Validation professionnelle', () {
    test('Une expérience comprise entre 0 et 50 est valide', () {
      expect(Validators.experience('5'), isNull);
      expect(Validators.experience('0'), isNull);
    });

    test('Une expérience de 75 ans est refusée', () {
      expect(
        Validators.experience('75'),
        'Valeur comprise entre 0 et 50',
      );
    });

    test('Un TJM avec virgule est accepté', () {
      expect(Validators.tjm('350,50'), isNull);
    });

    test('Un TJM trop faible est refusé', () {
      expect(Validators.tjm('25'), isNotNull);
    });

    test('Une biographie vide est acceptée', () {
      expect(Validators.biographie(''), isNull);
    });

    test('Une biographie trop courte est refusée', () {
      expect(Validators.biographie('Je code.'), isNotNull);
    });
  });
}
