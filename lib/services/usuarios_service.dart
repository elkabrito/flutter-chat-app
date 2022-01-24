import 'package:flutter_chat/models/usuario.dart';
import 'package:flutter_chat/models/usuarios_response.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/usuarios');

      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });

     // print(resp.body);

      final usuariosResponse = usuariosResponseFromJson(resp.body);

     // print('usuarios' + usuariosResponse.usuarios.length.toString() );

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
