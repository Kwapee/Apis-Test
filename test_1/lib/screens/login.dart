import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert'; // Import for jsonEncode
import 'signup.dart';
import 'top.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email, _password;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _Key = GlobalKey<FormState>();

  Future<void> _loginUser() async {
    if (_Key.currentState!.validate()) {
      _Key.currentState!.save(); // Save the form data

      // Prepare the data to send
      final Map<String, dynamic> loginData = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };

      // Send the POST request
      final response = await http.post(
        Uri.parse('http://3.20.63.91:8000/auth/user/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginData),
      );

      // Handle the response
      if (response.statusCode == 200) {
        // Login successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TopPage()),
        );
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login: ${response.body}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _Key,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      suffixIcon: Icon(
                        FontAwesomeIcons.envelope,
                        size: 17,
                      ),
                    ),
                    validator: (value) {
                      if (!value!.contains('@')) {
                        return 'Provide a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter Password',
                      suffixIcon: Icon(
                        FontAwesomeIcons.eyeSlash,
                        size: 17,
                      ),
                    ),
                    
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 230.0,
                  ),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 80.0, left: 80.0),
                  child: OutlinedButton(
                    onPressed: _loginUser,
                    child: const Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 15,
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ), // Call the login method
                  ),
                ),
                OutlinedButton(
                  child: const Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 15,
                      child: Text(
                        'You don`t have an account? Click here to register.',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
