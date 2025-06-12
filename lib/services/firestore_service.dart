import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrition_tracker/models/user_model.dart';
import 'package:nutrition_tracker/models/food_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUserProfile(UserModel user) async {
    await _usersCollection.doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUserProfile(String uid) async {
    DocumentSnapshot doc = await _usersCollection.doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
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
