import 'package:flutter/material.dart';
import 'package:flutter_chat/helpers/mostrar_alerta.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/widgets/boton_azul.dart';

import 'package:flutter_chat/widgets/custom_input.dart';
import 'package:provider/provider.dart';
import '../widgets/labels_widget.dart';
import '../widgets/logo_widget.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Messenger'),
                _Form(),
                Labels(
                  ruta: 'register',
                  titulo: '¿No tienes cuenta?',
                  subtitulo: 'Crear una ahora!',
                ),
                Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      )     
   );
  }
}

class _Form extends StatefulWidget {
  
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

   final authService = Provider.of<AuthService> (context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
           
           CustomInput(
             icon: Icons.mail_outline,
             placeholder: 'Email',
             keyboardType: TextInputType.emailAddress,
             textController: emailCtrl,
           ),
           CustomInput(
             icon: Icons.lock_outline,
             placeholder: 'Contraseña',             
             textController: passCtrl,
           ),
           
          BotonAzul(text: 'Ingrese', 
            onPressed: authService.autenticando ? null : () async {            

            FocusScope.of(context).unfocus();
         
            final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

            if(loginOk){
              // TODO: Navegar a otra pantalla

            }else{
              // Mostrar alerta
              mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
            }

          },
          )      
          
        ],
      ),
    );
  }
}

