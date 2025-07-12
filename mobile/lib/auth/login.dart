import 'package:flutter/material.dart';
import 'package:mobile/auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  void setAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Masuk Akun'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Masuk Notes App',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height:30),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: TextField(
                controller:username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: TextField(
                controller: password,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height:20),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: OutlinedButton(
                onPressed: null,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal:36, vertical:12),
                  child: Text('Masuk', style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*0.15),
                  child: const Text(
                    'Belum Punya Akun ?',
                    style: TextStyle(fontSize: 15),
                  ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder:(context) => const RegistrationScreen()),
                          );
                        },
                        child: const Text(
                          'Daftar',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}