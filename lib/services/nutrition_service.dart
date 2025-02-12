import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionService {
  final String apiKey = 'YOUR_API_KEY';
  final String apiUrl = 'https://api.nutritionix.com/v1_1/search';

  Future<Map<String, dynamic>> getNutritionData(String query) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-app-id': 'YOUR_APP_ID',
        'x-app-key': apiKey,
      },
      body: jsonEncode({
        'query': query,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load nutrition data');
    }
  }
}
