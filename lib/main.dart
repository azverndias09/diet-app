import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutrition_tracker/providers/user_provider.dart';
import 'package:nutrition_tracker/screens/profile_setup_screen.dart';
import 'package:nutrition_tracker/screens/food_logging_screen.dart';
import 'package:nutrition_tracker/screens/daily_insights_screen.dart';
import 'package:nutrition_tracker/screens/feedback_screen.dart';
import 'package:nutrition_tracker/screens/reports_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'Nutrition Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/profile',
        routes: {
          '/profile': (context) => ProfileSetupScreen(),
          '/home': (context) => HomeScreen(),
          '/log': (context) => FoodLoggingScreen(),
          '/insights': (context) => DailyInsightsScreen(),
          '/feedback': (context) => FeedbackScreen(),
          '/reports': (context) => ReportsScreen(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/log');
              },
              child: Text('Log Food'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/insights');
              },
              child: Text('Daily Insights'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/feedback');
              },
              child: Text('Feedback'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reports');
              },
              child: Text('Reports'),
            ),
          ],
        ),
      ),
    );
  }
}
