import 'package:flutter/material.dart';
import 'package:nutrition_tracker/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:nutrition_tracker/models/food_model.dart';
import 'package:nutrition_tracker/services/firestore_service.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<UserProvider>(context, listen: false).user!.id!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
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
            return ListView.builder(
              itemCount: foodLogs.length,
              itemBuilder: (context, index) {
                FoodModel food = foodLogs[index];
                return ListTile(
                  title: Text(food.name ?? ''),
                  subtitle: Text('${food.calories} kcal'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
