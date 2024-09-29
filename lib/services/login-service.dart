import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noticia_app/views/login-page.dart';
import 'package:noticia_app/views/dashboard-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:noticia_app/models/usuario-model.dart';
import 'package:noticia_app/settings.dart';

class LoginService extends ChangeNotifier {
  bool _isLoggedIn = false; 
  String? _token; 
  bool get isAuthenticated => _isLoggedIn; 

  Future<Usuario> criarConta(String nome, String email, String senha) async {
    var url = "${Settings.apiNovaUrl}users";

    Map data = {
      'nome': nome,
      'email': email,
      'password': senha,
    };

    Dio dio = new Dio();
    dio.options.headers["content-type"] = 'application/json';
    dio.options.headers["accept"] = 'application/json';
    print("Sending request to: $url");
    print("Request data: $data");
    var result = await dio.post(url, data: data);
    var usuario = Usuario.fromJson(result.data);
    return usuario;
  }

  Future<bool> login(String email, String senha) async {
    print("Logged in with: $email, $senha");

    var url = "${Settings.apiNovaUrl}auth/login";

    Map data = {
      'username': email,
      'password': senha,
    };

    try {
      Dio dio = new Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Access-Control-Allow-Origin"] = '*';
      dio.options.headers["Access-Control-Allow-Credentials"] = true;
      dio.options.headers["Access-Control-Allow-Headers"] =
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
      dio.options.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS";
      
      var result = await dio.post(url, data: data);
      print("Response: $result");
        if (result.statusCode == 200) {
        _isLoggedIn = true; 
        _token = result.data['token']; 
        notifyListeners(); 
        return true;
      }
      
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void logout() {
    _isLoggedIn = false;
    _token = null;
    notifyListeners(); 
  }
}



