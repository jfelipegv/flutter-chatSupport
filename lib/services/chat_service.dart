import 'package:chat_support/global/environment.dart';
import 'package:chat_support/models/mensajes_response.dart';
import 'package:chat_support/services/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/usuario.dart';

class ChatService with ChangeNotifier {
  Usuario? usuarioPara;

  Future getChat(String usuarioID) async {
    final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');
    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken().toString(),
      },
    );

    final mensajesResp = mensajesResponseFromJson(resp.body);
    return mensajesResp.mensajes;
  }
}
