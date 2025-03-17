import 'package:chat_support/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                Text('Registrate', style: TextStyle(color: const Color.fromARGB(255, 18, 16, 86),
                fontSize: 30,
                fontWeight: FontWeight.bold,),),
                _Form(),
                Labels(ruta: 'login', cuenta: '¿Ya tienes una cuenta?', creaLogin: 'Ingresa ahora',),
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
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
           CustomInput(
            hintText: 'Nombre',
            prefixIcon: Icon(Icons.perm_identity),
            isPassword: false,
            keyboardTiype: TextInputType.text,
            textController: nameCtrl,
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
            text: 'Registrarse',
            onPressed: () {
           
            },
          ),
        ],
      ),
    );
  }
}
