import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String text;
  final Function()? onPressed;

  const BotonAzul({ 
      Key? key, 
      required this.text, 
      required this.onPressed }) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
             onPressed: this.onPressed,  
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
               shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),               
             ),                                  
          child: Container(
            width: double.infinity,
            child: Center(
              child: Text(text, style: TextStyle(color: Colors.white, fontSize: 17),),
            ),
          ),          
          );
  }
}