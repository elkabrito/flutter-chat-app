import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_chat/models/usuario.dart';



class UsuariosPage extends StatefulWidget {

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'Maria', email: 'tes1@test.com', online: true),
    Usuario(uid: '2', nombre: 'Jose', email: 'tes2@test.com', online: true),
    Usuario(uid: '3', nombre: 'Lili', email: 'tes3@test.com', online: false),
    Usuario(uid: '4', nombre: 'Edu', email: 'tes4@test.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi nombre', style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54,), 
          onPressed: () {  },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400],),
            //child: Icon(Icons.offline_bolt, color: Colors.red,),
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
      );
  }

   _cargarUsuarios() async {

    await Future.delayed(Duration(microseconds:1000 ));
    _refreshController.refreshCompleted();
  }
}