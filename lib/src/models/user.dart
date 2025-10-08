class User {
  final String uid;
  final String? email;
  final String? name;
  final String? role; // 'Villager' or 'ASHA Worker'

  User({
    required this.uid,
    this.email,
    this.name,
    this.role,
  });
}