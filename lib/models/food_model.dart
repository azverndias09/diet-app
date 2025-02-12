class FoodModel {
  String? id;
  String? name;
  double? quantity;
  double? calories;
  double? carbs;
  double? proteins;
  double? fats;

  FoodModel({
    this.id,
    this.name,
    this.quantity,
    this.calories,
    this.carbs,
    this.proteins,
    this.fats,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'calories': calories,
      'carbs': carbs,
      'proteins': proteins,
      'fats': fats,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      calories: map['calories'],
      carbs: map['carbs'],
      proteins: map['proteins'],
      fats: map['fats'],
    );
  }
}
