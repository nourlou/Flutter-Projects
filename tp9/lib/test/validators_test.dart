import 'package:flutter_test/flutter_test.dart';
import 'package:tp9/utils/validators.dart';

void main() {
  group('Validation du nom et du prénom', () {
    test('refuse un nom vide', () {
      expect(
        Validators.nom(' ', champ: 'Le nom'),
        'Le nom est obligatoire',
      );
    });

    test('refuse un nom trop court', () {
      expect(
        Validators.nom('A', champ: 'Le nom'),
        'Le nom doit contenir au moins 2 caractères',
      );
    });

    test('accepte les accents', () {
      expect(
        Validators.nom('Élodie', champ: 'Le prénom'),
        isNull,
      );
    });

    test('refuse les chiffres dans le nom', () {
      expect(
        Validators.nom('Ben 3li', champ: 'Le nom'),
        'Le nom ne doit contenir que des lettres',
      );
    });
  });

  group('Validation de l’e-mail', () {
    test('accepte une adresse correcte', () {
      expect(
        Validators.email('ali@example.com'),
        isNull,
      );
    });

    test('refuse une adresse incorrecte', () {
      expect(
        Validators.email('ali@gmail'),
        'Format attendu : nom@domaine.com',
      );
    });
  });

  group('Validation du mot de passe', () {
    test('exige une majuscule', () {
      expect(
        Validators.motDePasse('bonjour12'),
        'Au moins une lettre majuscule',
      );
    });

    test('exige un chiffre', () {
      expect(
        Validators.motDePasse('Bonjourxx'),
        'Au moins un chiffre',
      );
    });

    test('accepte un mot de passe valide', () {
      expect(
        Validators.motDePasse('Bonjour12'),
        isNull,
      );
    });
  });

  group('Confirmation du mot de passe', () {
    test('refuse deux mots de passe différents', () {
      expect(
        Validators.confirmation('Autre1234', 'Bonjour12'),
        'Les mots de passe ne correspondent pas',
      );
    });

    test('accepte deux mots de passe identiques', () {
      expect(
        Validators.confirmation('Bonjour12', 'Bonjour12'),
        isNull,
      );
    });
  });

  group('Validation de la profession', () {
    test('refuse une profession vide', () {
      expect(
        Validators.profession(''),
        'La profession est obligatoire',
      );
    });

    test('accepte une profession valide', () {
      expect(
        Validators.profession('Développeur'),
        isNull,
      );
    });
  });

  group('Validation de l’expérience', () {
    test('refuse une expérience supérieure à 50', () {
      expect(
        Validators.experience('75'),
        'Valeur comprise entre 0 et 50',
      );
    });

    test('accepte zéro année d’expérience', () {
      expect(
        Validators.experience('0'),
        isNull,
      );
    });
  });

  group('Validation du TJM', () {
    test('refuse un montant inférieur à 50', () {
      expect(
        Validators.tjm('25'),
        'Le TJM doit être compris entre 50 € et 3000 €',
      );
    });

    test('accepte la virgule décimale', () {
      expect(
        Validators.tjm('350,50'),
        isNull,
      );
    });

    test('refuse un montant invalide', () {
      expect(
        Validators.tjm('abc'),
        'Montant invalide',
      );
    });
  });

  group('Validation de la biographie', () {
    test('accepte une biographie vide', () {
      expect(
        Validators.biographie(''),
        isNull,
      );
    });

    test('refuse une biographie trop courte', () {
      expect(
        Validators.biographie('Je code.'),
        contains('Au moins 20 caractères'),
      );
    });

    test('accepte une biographie suffisamment longue', () {
      expect(
        Validators.biographie(
          'Je suis développeur Flutter.',
        ),
        isNull,
      );
    });
  });
}