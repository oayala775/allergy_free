class User {
  final int? id;
  final String username;
  final String password;
  final int age;
  final int avatarId;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.age,
    required this.avatarId,
  });

  User.empty():
    id = 0,
    avatarId = 0,
    age = 0,
    username = '',
    password = '';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'age': age,
      'avatar_id': avatarId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      age: map['age'],
      avatarId: map['avatar_id'],
    );
  }
}
