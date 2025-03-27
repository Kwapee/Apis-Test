import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http show get;
import 'package:test_1/model/user.dart' show User;
import 'package:test_1/model/user_name.dart';


class UserApi{
   static Future<List<User>> fetchUsers() async {
    //print("FetchUsers called");
    const url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((e) {
      final name = UserName(
          title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last']
        );
      return User(
        cell: e['cell'],
        email: e['email'],
        gender: e['gender'],
        phone: e['phone'],
        nat: e['nat'],
        name: name,
      );
    }).toList();
    return users;

    //print("fetchUser  completed");
  }
}