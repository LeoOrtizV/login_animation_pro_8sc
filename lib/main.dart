import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; //Siempre importaciones

void main() {
  runApp(const MyApp()); //Para que la app se ejecute
}

class MyApp extends StatelessWidget { //StatelessWidget Sin estado
  const MyApp({super.key});

  // This widget is the root of your application.
  @override //Sobrescribir metodos
  Widget build(BuildContext context) { //Metodo que construye la app
    return MaterialApp( //Cupertino para iOS
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}

