import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_programing/reposiotries/api.dart';
import 'package:test_programing/session/session.dart';

class AuthRepository {
  Future<void> auth(
      {required String username,
      required String password,
      required context}) async {
    try {
      final body = jsonEncode({
        "username": username.toString(),
        "password": password.toString(),
      });
      final response = await http.post(Uri.parse(EndPoint.auth),
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: body);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Session().storeSave(stores: data['stores'], isLogin: true);
      } else {
        throw data['message'];
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
