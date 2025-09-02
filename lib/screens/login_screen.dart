import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true; // 👀 estado para mostrar/ocultar contraseña
  @override
  Widget build(BuildContext context) {
    //Para obtener el tamaño de la pantalla del dispositivo
    final Size size = MediaQuery.of(context).size;
    return Scaffold( //Widget para crear la estructura basica de una pantalla
      //SafeArea para evitar que los elementos se superpongan con la barra de estado o la barra de navegación
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            //Axis o eje vertical
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Animacion
              SizedBox(
                //Ancho de la pantalla calculado por MediaQuery
                width: size.width,
                height: 200,
                child: RiveAnimation.asset('animated_login_character.riv')
                ),

                //Espacio entre la animacion y el texto
                SizedBox(height: 10,),
                TextField(
                  //Teclado de tipo email
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                      //Bordes circulares
                      borderRadius: BorderRadius.circular(12),
                    )
                  ),
                ),

                SizedBox(height: 10,),
                TextField(
                  //Para que se oculte la contraseña
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      //Bordes circulares
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: (){
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  ),
                ),

                const SizedBox(height: 10,),
                SizedBox(
                  width: size.width,
                  child: const Text(
                    "Forgot your password?",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      decoration: TextDecoration.underline
                    ),
                  ),
                )
             ],
          ),
        ),
      ),
    );
  }
}