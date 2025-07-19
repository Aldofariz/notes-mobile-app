import 'package:flutter/material.dart';
import 'package:mobile/auth/login.dart';
import 'package:dio/dio.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(221, 18, 74, 148),
        title: const Text('Notes App' , style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: const Color.fromARGB(255, 8, 21, 32),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Daftar Notes App',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: username,
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
                style: TextStyle(color: Colors.white),
                controller: fullname,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: password,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: cpassword,
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: ElevatedButton(
                onPressed: isButtonDisabled || isLoading? null: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                  ? const Padding(
                    padding: 
                      EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      child: SizedBox(
                        height: 20,
                        width:20,
                        child: CircularProgressIndicator(
                          strokeWidth:3, 
                          color: Colors.black87,
                        ),
                      ),
                  )
                : const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  child: Text(
                    'Daftar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                  ),
                  child: const Text(
                    'Sudah punya akun ?',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Masuk',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  // Add these variables and methods inside _RegistrationScreenState
  bool isLoading = false;
  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    username.addListener(validateInput);
    fullname.addListener(validateInput);
    password.addListener(validateInput);
    cpassword.addListener(validateInput);
  }

  void validateInput() {
    setState(() {
      isButtonDisabled = !(username.text.isNotEmpty &&
          fullname.text.isNotEmpty &&
          password.text.isNotEmpty &&
          cpassword.text.isNotEmpty &&
          password.text == cpassword.text);
    });
  }

  void registerUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await Dio().post(
        'http://localhost:8000/register',
        data: {
          'username': username.text,
          'fullname': fullname.text,
          'password': password.text,
        },
      );

      if (response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    } catch (error) {
      // Handle response
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Color(0xFF1E1E1E), // warna gelap
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Username already exist. Please try again.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}