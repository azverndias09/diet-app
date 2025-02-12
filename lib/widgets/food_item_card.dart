import 'package:flutter/material.dart';
import 'package:nutrition_tracker/models/food_model.dart';

class FoodItemCard extends StatelessWidget {
  final FoodModel food;

  FoodItemCard({required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(food.name ?? ''),
        subtitle: Text('${food.calories} kcal'),
        trailing: Text('${food.quantity} g'),
      ),
    );
  }
}
