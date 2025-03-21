import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 40),
        width: 170,
        child: Column(
          children: [Image(image: AssetImage('assets/chatlogo.png'))],
        ),
      ),
    );
  }
}