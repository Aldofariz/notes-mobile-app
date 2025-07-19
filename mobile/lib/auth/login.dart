import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/notes/get_notes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isButtonDisabled = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    username.addListener(validateInput);
    password.addListener(validateInput);
  }

  void validateInput() {
    setState(() {
      isButtonDisabled =
          !(username.text.isNotEmpty && password.text.isNotEmpty);
    });
  }

  void login() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await Dio().post(
        'http://localhost:8000/login',
        data: {'username': username.text, 'password': password.text},
      );

      print(response.data);

      if (response.statusCode == 200) {
        setAccessToken(response.data['access_token']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GetNotesScreen()),
        );

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
                Icons.check_circle_outline,
                color: Colors.greenAccent,
                size: 60,
              ),
              SizedBox(height: 15),
              Text(
                'Success',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Login berhasil',
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

      }
    } catch (e) {
      print(e);
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
                    color: Colors.redAccent,
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
                    'Login gagal. Periksa koneksi internet atau kredensial Anda.',
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

  void setAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(221, 18, 74, 148)),
      backgroundColor: const Color.fromARGB(255, 8, 21, 32),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Masuk Notes App',
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
                  labelStyle: TextStyle(color: Colors.white12),
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
                  labelStyle: TextStyle(color: Colors.white12),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: OutlinedButton(
                onPressed: isButtonDisabled || isLoading ? null : login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    color:
                        isButtonDisabled || isLoading
                            ? Colors.white12
                            : Colors.white,
                  ),
                ),
                child:
                    isLoading
                        ? const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 12,
                          ),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                        : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 12,
                          ),
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              color:
                                  isButtonDisabled
                                      ? Colors.white12
                                      : Colors.white,
                            ),
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
                    'Belum punya akun ?',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Daftar',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 15),
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