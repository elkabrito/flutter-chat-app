import 'package:flutter/material.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/chat_service.dart';
import 'package:flutter_chat/services/socket_service.dart';
import 'package:flutter_chat/services/usuarios_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_chat/models/usuario.dart';



class UsuariosPage extends StatefulWidget {

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  final usuarioService = new UsuariosService();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<Usuario> usuarios = [];


  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;


    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombre, style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54,), 
          onPressed: () { 
            
            socketService.disconnect();                        
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();

           },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: ( socketService.serverStatus == ServerStatus.Online )
             ? Icon(Icons.check_circle, color: Colors.blue[400],) 
             : Icon(Icons.offline_bolt, color: Colors.red,),            
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color:Colors.blue[400]),
          waterDropColor: Colors.blue,
        ),
        child: _listViewUsuario(),
      )
   );
  }

  ListView _listViewUsuario() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: ( _ , i) => _usuarioListTitle(usuarios[i]), 
      separatorBuilder: (_ , i) => Divider(), 
      itemCount: usuarios.length);
  }

  ListTile _usuarioListTitle(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),        
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2),),          
          backgroundColor: Colors.blue[200],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(1000)
          ),
        ),
        onTap: (){
           final chatService = Provider.of<ChatService>(context, listen: false);
           chatService.usuarioPara = usuario;
           Navigator.pushNamed(context, 'chat');
        },
      );
  }

   _cargarUsuarios() async {

     
    usuarios = await usuarioService.getUsuarios();

    setState(() {
      
    });

    //await Future.delayed(Duration(microseconds:1000 ));

    _refreshController.refreshCompleted();
  }
}