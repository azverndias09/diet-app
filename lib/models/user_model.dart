class UserModel {
  String? id;
  String? name;
  int? age;
  String? gender;
  double? height;
  double? weight;
  String? medicalConditions;
  String? activityLevel;

  UserModel({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.medicalConditions,
    this.activityLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'medicalConditions': medicalConditions,
      'activityLevel': activityLevel,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      height: map['height'],
      weight: map['weight'],
      medicalConditions: map['medicalConditions'],
      activityLevel: map['activityLevel'],
    );
  }
}
