import 'package:http/http.dart' as http;
import 'package:nutrition_tracker/models/food_model.dart';
import 'dart:convert';

class NutritionService {
  final String apiKey = 'UVN2lrdZK+01MKr6W+1uVQ==zYdlZog9g3JUmucs';
  final String apiUrl = 'https://api.calorieninjas.com/v1/nutrition';

  // Method to get the raw nutrition data as a Map.
  Future<Map<String, dynamic>> getNutritionData(String query) async {
    final uri = Uri.parse('$apiUrl?query=$query');
    final response = await http.get(
      uri,
      headers: {
        'X-Api-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load nutrition data: ${response.statusCode}');
    }
  }

  // Method to create a fully populated FoodModel from the API response.
  Future<FoodModel> fetchFoodDetails(String foodName, double quantity) async {
    final data = await getNutritionData(foodName);

    if (data['items'] != null && data['items'].isNotEmpty) {
      final item = data['items'][0];

      return FoodModel(
        name: item['name'] ?? foodName,
        quantity: quantity,
        calories: item['calories'] != null
            ? ((item['calories'] as num).toDouble() / 100) * quantity
            : 0.0,
        carbs: item['carbohydrates_total_g'] != null
            ? ((item['carbohydrates_total_g'] as num).toDouble() / 100) *
                quantity
            : 0.0,
        proteins: item['protein_g'] != null
            ? ((item['protein_g'] as num).toDouble() / 100) * quantity
            : 0.0,
        fats: item['fat_total_g'] != null
            ? ((item['fat_total_g'] as num).toDouble() / 100) * quantity
            : 0.0,
      );
    } else {
      // Fallback: Return a FoodModel with zeroed nutrition values if no details found.
      return FoodModel(
        name: foodName,
        quantity: quantity,
        calories: 0.0,
        carbs: 0.0,
        proteins: 0.0,
        fats: 0.0,
      );
    }
  }
}
