import 'package:chat_support/pages/login_page.dart';
import 'package:chat_support/pages/usuarios_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: CircularProgressIndicator(color: Colors.lightGreen),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();

    if (autenticado!) {
      socketService.connect();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (_, __, ___) => UsuariosPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (_, __, ___) => LoginPage(),
        ),
      );
    }
  }
}
