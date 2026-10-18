
class UserProfile {
  final String nom;
  final String prenom;
  final String email;
  final String password;
  final String profession;
  final int? experience;
  final double? tjm;
  final String biographie;

  const UserProfile({
    this.nom = '',
    this.prenom = '',
    this.email = '',
    this.password = '',
    this.profession = '',
    this.experience,
    this.tjm,
    this.biographie = '',
  });

  UserProfile copyWith({
    String? nom,
    String? prenom,
    String? email,
    String? password,
    String? profession,
    int? experience,
    double? tjm,
    String? biographie,
  }) {
    return UserProfile(
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      password: password ?? this.password,
      profession: profession ?? this.profession,
      experience: experience ?? this.experience,
      tjm: tjm ?? this.tjm,
      biographie: biographie ?? this.biographie,
    );
  }
}
