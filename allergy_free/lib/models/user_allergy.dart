class UserAllergy {
  final int? id;
  final int userId;
  final int allergyId;

  UserAllergy({this.id, required this.userId, required this.allergyId});

  Map<String, dynamic> toMap() {
    return {'id': id, 'user_id': userId, 'allergy_id': allergyId};
  }

  factory UserAllergy.fromMap(Map<String, dynamic> map) {
    return UserAllergy(
      id: map['id'],
      userId: map['user_id'],
      allergyId: map['allergy_id'],
    );
  }
}
