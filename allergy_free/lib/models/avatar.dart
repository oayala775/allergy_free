class Avatar {
  final int? id;
  final String avatarName;
  final String avatarPath;

  Avatar({this.id, required this.avatarName, required this.avatarPath});

  Map<String, dynamic> toMap() {
    return {'id': id, 'avatar_name': avatarName, 'avatar_path': avatarPath};
  }

  factory Avatar.fromMap(Map<String, dynamic> map) {
    return Avatar(
      id: map['id'],
      avatarName: map['avatar_name'],
      avatarPath: map['avatar_path'],
    );
  }
}
