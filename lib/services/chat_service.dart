import 'package:flutter/material.dart';
import 'package:flutter_chat/models/mensajes_response.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import '../models/usuario.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    final mensajeResponse = mensajesResponseFromJson(resp.body);

    return mensajeResponse.mensajes;
  }
}
