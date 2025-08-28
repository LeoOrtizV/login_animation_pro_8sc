import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( //Widget para crear la estructura basica de una pantalla
      //SafeArea para evitar que los elementos se superpongan con la barra de estado o la barra de navegación
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: RiveAnimation.asset('animated_login_character.riv')),
            ],
          ),
        ),
    );
  }
}