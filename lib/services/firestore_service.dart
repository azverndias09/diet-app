import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrition_tracker/models/user_model.dart';
import 'package:nutrition_tracker/models/food_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserProfile(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUserProfile(String userId) async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> logFood(String userId, FoodModel food) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('foods')
        .add(food.toMap());
  }

  Future<List<FoodModel>> getFoodLogs(String userId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('foods')
        .get();
    return snapshot.docs
        .map((doc) => FoodModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveFeedback(String feedback) async {
    await _firestore.collection('feedback').add({
      'feedback': feedback,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
