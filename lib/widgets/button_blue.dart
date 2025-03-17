import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  const ButtonBlue({super.key, required this.text, required this.onPressed});

  final String text;
  final Function()? onPressed;

  // final TextEditingController emailCtrl;
  // final TextEditingController passCtrl;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        padding: EdgeInsets.only(left: 30, right: 30),
        backgroundColor: Color.fromARGB(255, 18, 16, 86),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 22, color: Colors.orangeAccent),
      ),
    );
  }
}
