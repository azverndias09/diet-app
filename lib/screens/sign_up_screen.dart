// // Example sign-up function (this would be in your sign-up screen)
// Future<void> registerUser(String email, String password) async {
//   final firebaseUser =
//       await AuthService().registerWithEmailAndPassword(email, password);
//   if (firebaseUser != null) {
//     // Create a minimal user model using Firebase uid
//     UserModel newUser = UserModel(id: firebaseUser.uid);

//     // Save this minimal profile to Firestore
//     await FirestoreService().saveUserProfile(newUser);

//     // Update the provider with the new user
//     Provider.of<UserProvider>(context, listen: false).setUser(newUser);

//     // Navigate to ProfileSetupScreen for additional details
//     Navigator.pushReplacementNamed(context, '/profileSetup');
//   } else {
//     // Handle registration error (e.g., show a message to the user)
//   }
// }
