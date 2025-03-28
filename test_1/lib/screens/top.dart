import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http show get;
import 'package:test_1/model/user.dart';
//import 'package:test_1/model/user.dart';
import 'package:test_1/model/user_name.dart';
import 'package:test_1/service/user_api.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Column(children: [
            Text(
              "API Testing",
              style: TextStyle(color: Colors.black),
            ),
          ]),
        ),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user.email;
            final Color = user.gender == 'male' ? Colors.blue : Colors.red;
            return ListTile(
              title: Text(user.fullName),
              subtitle: Text(user.location.city),
            );
          }),
    );
  }

  Future<void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}
