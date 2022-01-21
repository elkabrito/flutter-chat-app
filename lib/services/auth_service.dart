import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../global/environment.dart';
import '../models/usuario.dart';

class AuthService with ChangeNotifier{

     late Usuario usuario;

     bool _autenticando = false;

     final _storage = new FlutterSecureStorage();

     bool get autenticando => _autenticando;
     set autenticando( bool valor){
       _autenticando = valor;
       notifyListeners();
     }

    Future<bool> login( String email, String password) async {

      this.autenticando = true;


       final data = {
         'email': email,
         'password': password
       };

     final uri = Uri.parse('${ Environment.apiUrl }/login');

       final resp = await http.post( uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json'
        }
      );

      print(resp.body);
      this.autenticando = false;

      if(resp.statusCode == 200){
       final loginResponse = loginResponseFromJson(resp.body);
       usuario = loginResponse.usuario;

       // TODO: Guardar token en lugar seguro

       return true;
      }
      else{
        return false;
      }

      
    
    }



  Future _guardarToken(String token) async{
     return await _storage.write(key: 'token', value: token);
  }

}