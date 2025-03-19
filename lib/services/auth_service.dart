import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chat_support/global/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;

  // Create storage
  static final _storage = FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estática para acceder de esta manera authservice.token
  static Future<String?> getToken() async {
    try {
      // final _storage = FlutterSecureStorage();
      return await _storage.read(key: 'token');
    } catch (e) {
      return null; // Retorna null en caso de error
    }
  }

  static Future<String?> deleteToken() async {
    //  final _storage = FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {'email': email, 'password': password};
    final uri = Uri.parse('${Environment.apiUrl}/login/');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    final data = {'nombre': nombre, 'email': email, 'password': password};
    final uri = Uri.parse('${Environment.apiUrl}/login/new');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      final registerResponse = LoginResponse.fromJson(resp.body);
      usuario = registerResponse.usuario;
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool?> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final uri = Uri.parse('${ Environment.apiUrl}/login/renovar');
     final resp = await http.get(uri,
      headers: {
      'Content-Type': 'application/json',
      'x-token': token.toString()
      }
    );

    if (resp.statusCode == 200) {
      final tokenResponse = LoginResponse.fromJson(resp.body);
      usuario = tokenResponse.usuario;
      await _guardarToken(tokenResponse.token);
      return true;
    } else {
      logOut();
      return false;
    }
  }

  

  Future _guardarToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future logOut() async {
    // Delete value
    await _storage.delete(key: 'token');
  }
}
