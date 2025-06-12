import 'package:flutter/material.dart';
import 'package:nutrition_tracker/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:nutrition_tracker/models/food_model.dart';
import 'package:nutrition_tracker/services/firestore_service.dart';
import 'package:nutrition_tracker/services/nutrition_service.dart';

class FoodLoggingScreen extends StatefulWidget {
  @override
  _FoodLoggingScreenState createState() => _FoodLoggingScreenState();
}

class _FoodLoggingScreenState extends State<FoodLoggingScreen> {
  final _foodController = TextEditingController();
  final _quantityController = TextEditingController();
  final NutritionService _nutritionService = NutritionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _foodController,
              decoration: InputDecoration(labelText: 'Food Item'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity (g)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String foodItem = _foodController.text;
                double quantity = double.parse(_quantityController.text);

                // Use fetchFoodDetails to get a fully populated FoodModel.
                FoodModel food = await _nutritionService.fetchFoodDetails(
                    foodItem, quantity);

                String userId =
                    Provider.of<UserProvider>(context, listen: false).user!.id!;
                await FirestoreService().logFood(userId, food);

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Food logged successfully!')));
              },
              child: Text('Log Food'),
            ),
          ],
        ),
      ),
    );
  }
}
