import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.texto, required this.uid, required this.animationController});

  final String texto;
  final String uid;
  final AnimationController animationController; 

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.bounceInOut),
        child: Container(child: uid == '123' ? _myMessage() : _notMyMessage())));
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 5, left: 40, right: 5),
        padding: EdgeInsets.all(8.0),
        child: Text(texto, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 40),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(58, 147, 147, 147),
          borderRadius: BorderRadius.circular(10),
        ),
         child: Text(texto, style: TextStyle(color: Colors.black87)),
      ),
    );
  }
}
