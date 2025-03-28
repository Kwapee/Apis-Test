import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http show get;
import 'package:test_1/model/user.dart' show User;
import 'package:test_1/model/user_dob.dart';
//import 'package:test_1/model/user_location.dart';
import 'package:test_1/model/user_name.dart';

import '../model/user_location.dart'
    show
        LocationStreet,
        LocationTimezoneCoordinates,
        LocationsCoordinates,
        UserLocation;

class UserApi {
  static Future<List<User>> fetchUsers() async {
    //print("FetchUsers called");
    const url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((e) {
      return User.fromMap(e);
    }).toList();
    return users;

    //print("fetchUser  completed");
  }
}
