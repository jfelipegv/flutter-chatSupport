import 'package:chat_support/helpers/mostrar_alerta.dart';
import 'package:chat_support/services/auth_service.dart';
import 'package:chat_support/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 240, 224),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // efecto del scroll.
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(),
                _Form(),
                Labels(
                  ruta: 'register',
                  cuenta: '¿No tienes cuenta?',
                  creaLogin: 'Crea una ahora!',
                ),
                Text(
                  'Términos y condiciones de uso',
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Text(
            'Iniciar sesión',
            style: TextStyle(
              color: const Color.fromARGB(255, 18, 16, 86),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          CustomInput(
            hintText: 'Email',
            prefixIcon: Icon(Icons.mail_outline),
            isPassword: false,
            keyboardTiype: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          SizedBox(height: 20),
          CustomInput(
            hintText: 'Password',
            prefixIcon: Icon(Icons.password_outlined),
            isPassword: true,
            keyboardTiype: TextInputType.text,
            textController: passCtrl,
          ),
          SizedBox(height: 20),
          ButtonBlue(
            text: 'Ingresar',
            onPressed:
                authService.autenticando
                    ? null
                    : () async {
                      FocusScope.of(context).unfocus(); // ocultar el teclado
                      final loginOk = await authService.login(
                        emailCtrl.text.trim(),
                        passCtrl.text.trim(),
                      );
                      if (loginOk) {
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        //mostrar alerta
                        mostrarAlerta(
                          context,
                          'Login incorrecto',
                          'Revise sus credenciales',
                        );
                      }
                    },
          ),
        ],
      ),
    );
  }
}
