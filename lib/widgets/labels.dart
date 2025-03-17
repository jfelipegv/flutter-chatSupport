import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String cuenta;
  final String creaLogin;

  const Labels({super.key, required this.ruta, required this.cuenta, required this.creaLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            cuenta,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          GestureDetector(
            child: Text(
              creaLogin,
              style: TextStyle(
                color: const Color.fromARGB(255, 18, 16, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
          ),
        ],
      ),
    );
  }
}
