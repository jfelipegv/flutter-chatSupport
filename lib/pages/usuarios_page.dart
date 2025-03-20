import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/usuario.dart';
import '../services/services.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final usuariosService = UsuariosService();
  List<Usuario> usuariosList = [];
  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          usuario!.nombre,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
          icon: Icon(Icons.exit_to_app),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child:
                (socketService.serverStatus == ServerStatus.Online)
                    ? Icon(Icons.cloud_done_outlined, color: Colors.lightGreen)
                    : Icon(Icons.cloud_off_sharp, color: Colors.red),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check),
          waterDropColor: Colors.black45,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(), //efecto scroll de iphone
      itemBuilder: (_, i) => _usuarioListTile(usuariosList[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuariosList.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(165, 207, 216, 220),
        foregroundColor: Colors.black54,
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing:
      // usuariosList[i].online
      // ? Icon(Icons.double_arrow, color: Colors.lightGreen,)
      // : Icon(Icons.cancel, color: Colors.red)
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.lightGreen : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargarUsuarios() async {
    usuariosList = await usuariosService.getUsuarios();
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
