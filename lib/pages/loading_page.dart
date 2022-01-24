import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/login_page.dart';
import 'package:flutter_chat/pages/usuarios_page.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../services/socket_service.dart';



class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot){
          return Center(
            child: Text('Espee...'),
          );
        },      
      ),         
   );
  }


Future checkLoginState(BuildContext context) async{
  
   final authService = Provider.of<AuthService>(context, listen: false);
   final socketService = Provider.of<SocketService>(context, listen: false);

   final autenticado = await authService.isLoggedIn();
   
   if(autenticado){
     socketService.connect();


     Navigator.pushReplacement(
       context, 
       PageRouteBuilder(
       pageBuilder: ( _, __, ___, ) => UsuariosPage(),
       transitionDuration: Duration(milliseconds: 0)
     ));
   }
   else{
      Navigator.pushReplacement(
       context, 
       PageRouteBuilder(
       pageBuilder: ( _, __, ___, ) => LoginPage(),
       transitionDuration: Duration(milliseconds: 0)
     ));
   }

}

}




