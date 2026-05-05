import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginRegisterRepo {
  static const String _userKey = "user";

  Future<bool> register(
    String fullName,
    String shopName,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      if (password != confirmPassword) {
        throw Exception("Password does not match");
      }

      final prefs = await SharedPreferences.getInstance();

      Map<String, dynamic> user = {
        "full_name": fullName,
        "shop_name": shopName,
        "email": email,
        "password": password,
      };

      await prefs.setString(_userKey, jsonEncode(user));

      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final userString = prefs.getString(_userKey);

      if (userString == null) {
        throw Exception("User not found");
      }

      final user = jsonDecode(userString);

      if (user["email"] == email && user["password"] == password) {
        return true;
      }

      throw Exception("Invalid email or password");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final userString = prefs.getString(_userKey);

    if (userString == null) {
      return null;
    }

    return jsonDecode(userString);
  }
}
