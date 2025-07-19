import 'package:flutter/material.dart';
import 'auth/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 5)), 
      builder:(context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(237, 16, 65, 129),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Image.asset(
                    '/splas.png',
                    width: 600,
                    height: 650,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const LoginScreen();
        }
      }
      
      
    );
  }
}