import 'package:flutter/material.dart';
import 'news_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // Named 'key' parameter
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNewsPage(); // Start the navigation after a short delay
  }

  _navigateToNewsPage() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const NewsPage(),
            transitionsBuilder: (context, animation1, animation2, child) {
              var begin =
                  const Offset(1.0, 0.0); // Slide transition from the right
              var end = Offset.zero;
              var curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

              return SlideTransition(
                position: animation1.drive(tween),
                child: child,
              );
            },
            transitionDuration:
                const Duration(milliseconds: 500), // Duration of transition
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/json/newsapp.json', // Path to your Lottie JSON file
              width: 200, // Adjust size as needed
              height: 200,
            ),
            const CircularProgressIndicator(), // Adding a loading indicator
            const SizedBox(height: 10), // Space between widgets
            const Text(
                'Welcome to the News App!'), // Display a welcome message or logo
          ],
        ),
      ),
    );
  }
}
