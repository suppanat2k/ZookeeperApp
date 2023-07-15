import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserRepositories {
  static String get hostUrl => dotenv.get("API_HOST", fallback: "");
  static String urllogin = "$hostUrl/users/login";

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> hasToken() async {
    var value = await storage.read(key: "token");
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future usernameRead() async {
    var value = await storage.read(key: "username");
    return value;
  }

  Future passwordRead() async {
    var value = await storage.read(key: "password");
    return value;
  }

  Future roleRead() async {
    var value = await storage.read(key: "role");
    return value;
  }

  Future idRead() async {
    var value = await storage.read(key: "userId");
    return value;
  }

  Future<void> preToken(
      String token, String username, String password, String role,int userId) async {
    await storage.write(key: "token", value: token);
    await storage.write(key: "username", value: username);
    await storage.write(key: "password", value: password);
    await storage.write(key: "role", value: role);
    await storage.write(key: "userId", value: userId.toString());
  }

  Future<void> deleteToken() async {
    await storage.delete(key: "token");
    await storage.delete(key: "username");
    await storage.delete(key: "password");
    await storage.delete(key: "role");
    storage.deleteAll();
  }

  Future<String> login({
    required String username,
    required String password,
  }) async {
    Response res = await http.post(
      Uri.parse(urllogin),
      body: json.encode({"username": username, "password": password}),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
    );
    return res.body;
  }
}
