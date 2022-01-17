import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';

class AuthService with ChangeNotifier{

    // Usuario  usuario; ??

    Future login( String email, String password) async {

       final data = {
         'email': email,
         'password': password
       };

     print('llamando al login');


     final uri = Uri.parse('${ Environment.apiUrl }/login');

     print(uri);

    

       final resp = await http.post( uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json'
        }
      );
       print('el body');
       print(resp.body);
       
     

       

     


    

    }

}