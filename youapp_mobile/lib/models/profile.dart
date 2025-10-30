/// User profile model representing user data from the API
class UserProfile {
  final String id;
  final String username;
  final String? name;
  final String? email;
  final String? about;
  final List<String>? interests;

  const UserProfile({
    required this.id,
    required this.username,
    this.name,
    this.email,
    this.about,
    this.interests,
  });

  /// Creates a UserProfile from JSON data
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id']?.toString() ?? '',
      username: json['username'] ?? '',
      name: json['name'],
      email: json['email'],
      about: json['about'],
      interests: json['interest'] != null
          ? List<String>.from(json['interest'])
          : null,
    );
  }

  /// Converts UserProfile to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'about': about,
      'interest': interests,
    };
  }

  /// Creates a copy of UserProfile with optional new values
  UserProfile copyWith({
    String? id,
    String? username,
    String? name,
    String? email,
    String? about,
    List<String>? interests,
  }) {
    return UserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      about: about ?? this.about,
      interests: interests ?? this.interests,
    );
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, username: $username, name: $name, email: $email, about: $about, interests: $interests)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfile &&
        other.id == id &&
        other.username == username &&
        other.name == name &&
        other.email == email &&
        other.about == about &&
        other.interests == interests;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        name.hashCode ^
        email.hashCode ^
        about.hashCode ^
        interests.hashCode;
  }
}
