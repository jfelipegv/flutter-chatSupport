import 'package:chat_support/global/environment.dart';
import 'package:chat_support/models/models.dart';
import 'package:chat_support/services/services.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/usuarios');
      final resp = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': (await AuthService.getToken()) ?? '',
        },
      );

      final usuariosReponse = UsuariosResponse.fromJson(resp.body);
      return usuariosReponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
