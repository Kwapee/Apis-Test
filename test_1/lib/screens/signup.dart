import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // ignore: unused_field
  late String _fullName, _email, _password, _phoneNumber, _address;

  final nameController = TextEditingController();
  final secondnameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenumberController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final _Key = GlobalKey<FormState>();
  

  Future<void> _registerUser () async {
    if (_Key.currentState!.validate()) {
      _Key.currentState!.save(); // Save the form data

      // Prepare the data to send
      final Map<String, dynamic> userData = {
        "first_name": nameController.text, // Use the first name controller
        "last_name": secondnameController.text, // Use the second name controller
        "email": emailController.text,
        "password": passwordController.text,
        "user_access_level": "customer",
        "user_institution": 0,
      };

      // Send the POST request
      final response = await http.post(
        Uri.parse('http://3.20.63.91:8000/auth/create_user'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );

      // Handle the response
      if (response.statusCode == 200) {
        // User registered successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User  registered successfully!')),
        );
        // Optionally, navigate to another page or perform other actions
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register user: ${response.body}')),
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
                    padding: const EdgeInsets.only(top:100.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          labelText: 'First Name', hintText: 'Enter your name'),
                      
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:1.0),
                    child: TextFormField(
                      controller: secondnameController,
                      decoration: const InputDecoration(
                          labelText: 'Second Name', hintText: 'Enter your name'),
                     
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:1.0),
                    child: TextFormField(
                      controller: emailController,
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
                    padding: const EdgeInsets.only(top: 1.0),
                    child: TextFormField(
                      controller: passwordController,
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
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0,  left: 140),
                    child: OutlinedButton(
                      onPressed: _registerUser ,
                      child: const Text('Register', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  OutlinedButton(
                    child: const Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 15,
                        child: Text('Already have an account? click here to the login page', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
