class Allergy {
  final int? id;
  final String allergyName;
  final String? description;

  Allergy({this.id, required this.allergyName, this.description});

  Map<String, dynamic> toMap() {
    return {'id': id, 'allergy_name': allergyName, 'description': description};
  }

  factory Allergy.fromMap(Map<String, dynamic> map) {
    return Allergy(
      id: map['id'],
      allergyName: map['allergy_name'],
      description: map['description'],
    );
  }
}
