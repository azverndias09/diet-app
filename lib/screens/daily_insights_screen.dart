import 'package:flutter/material.dart';
import 'package:nutrition_tracker/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:nutrition_tracker/models/food_model.dart';
import 'package:nutrition_tracker/services/firestore_service.dart';

class DailyInsightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<UserProvider>(context, listen: false).user!.id!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Insights'),
      ),
      body: FutureBuilder<List<FoodModel>>(
        future: FirestoreService().getFoodLogs(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No food logs found.'));
          } else {
            List<FoodModel> foodLogs = snapshot.data!;
            double totalCalories =
                foodLogs.fold(0, (sum, food) => sum + (food.calories ?? 0));
            double totalCarbs =
                foodLogs.fold(0, (sum, food) => sum + (food.carbs ?? 0));
            double totalProteins =
                foodLogs.fold(0, (sum, food) => sum + (food.proteins ?? 0));
            double totalFats =
                foodLogs.fold(0, (sum, food) => sum + (food.fats ?? 0));

            return Column(
              children: [
                Text('Total Calories: $totalCalories kcal'),
                Text('Total Carbs: $totalCarbs g'),
                Text('Total Proteins: $totalProteins g'),
                Text('Total Fats: $totalFats g'),
                Expanded(
                  child: ListView.builder(
                    itemCount: foodLogs.length,
                    itemBuilder: (context, index) {
                      FoodModel food = foodLogs[index];
                      return ListTile(
                        title: Text(food.name ?? ''),
                        subtitle: Text('${food.calories} kcal'),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
