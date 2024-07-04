class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

class Professional {
  final int id;
  final int userId;
  final String? profilePicture;
  final String? address;
  final String? profession;
  final int? yearsOfExperience;
  final User user;

  Professional({
    required this.id,
    required this.userId,
    this.profilePicture,
    this.address,
    this.profession,
    this.yearsOfExperience,
    required this.user,
  });

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: json['user']['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      profilePicture: json['profilePicture'] as String?,
      address: json['address'] ?? '',
      profession: json['profession'] ?? '',
      yearsOfExperience: json['years_of_experience'] as int?,
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'profilePicture': profilePicture,
      'address': address,
      'profession': profession,
      'yearsOfExperience': yearsOfExperience,
    };
  }
}
