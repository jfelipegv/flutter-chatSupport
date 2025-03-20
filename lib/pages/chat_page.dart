import 'package:chat_support/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];
  bool _estaEscribiendo = false;
  ChatService? chatService;
  SocketService? socketService;
  AuthService? authService;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService!.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(chatService!.usuarioPara!.uid);
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje> chat = await chatService!.getChat(usuarioID);
    final history = chat.map(
      (m) => ChatMessage(
        texto: m.mensaje,
        uid: m.de,
        animationController: AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 0),
        )..forward(),
      ),
    );

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload) {
    ChatMessage message = ChatMessage(
      texto: payload['mensaje'],
      uid: payload['de'],
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioPara = chatService!.usuarioPara;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 4,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(165, 207, 216, 220),
              foregroundColor: Colors.black,
              child: Text(
                usuarioPara!.nombre.substring(0, 2),
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(height: 5),
            Text(
              usuarioPara!.nombre,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
              ),
            ),
            Divider(color: Colors.black12),
            Container(
              //TODO: caja de texto
              color: Colors.white,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Escribe un mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                onPressed:
                    _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                icon: Icon(
                  Icons.send,
                  color: _estaEscribiendo ? Colors.blueAccent : Colors.black12,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      texto: texto,
      uid: authService!.usuario!.uid,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });

    socketService!.emit('mensaje-personal', {
      'de': authService!.usuario!.uid,
      'para': chatService!.usuarioPara!.uid,
      'mensaje': texto,
    });
  }

  @override
  void dispose() {
    //TODO: off del socket
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    socketService!.socket.off('mensaje-personal');
    super.dispose();
  }
}
