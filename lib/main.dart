import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/news_provider.dart';

void main() async {
  // Load environment variables
  // await dotenv.load(); // This reads your .env file

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Fixed key parameter

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(), // Initialize your providers
        ),
      ],
      child: MaterialApp(
        home: const SplashScreen(), // Start with the splash screen
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );
  }
}
