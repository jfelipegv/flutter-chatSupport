import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../pages/usuarios.dart';


final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'register': (_) => RegisterPage(),
  'login': (_) => LoginPage(),
  'loading': (_) => LoadingPage(),
  'chat': (_) => ChatPage(),

};
