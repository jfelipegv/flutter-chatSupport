import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController textController;
  final TextInputType keyboardTiype;
  final bool isPassword;

  const CustomInput({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.textController,
    required this.keyboardTiype,
    required this.isPassword
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2,
        left: 2,
        bottom: 2,
        right: 20,
      ), //para respetar el margen cunando el input se llene
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color.fromARGB(15, 0, 0, 0),
            offset: Offset(0, 5),
            blurRadius: 2,
          ),
        ],
      ),
      child: TextField(
       controller: textController,
        style: TextStyle(fontSize: 25),
        autocorrect: false,
        keyboardType: keyboardTiype,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
