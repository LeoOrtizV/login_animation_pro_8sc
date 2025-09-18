import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Timer? _emailIdleTimer;

  //Cerebro de la lógica de animaciones
  StateMachineController? controller;

  //StateMachineInput
  SMIBool? isChecking; //Activa al oso chismoso
  SMIBool? isHandsUp; //Se tapa los ojos
  SMITrigger? trigSuccess; //Se emociona
  SMITrigger? trigFail; //Se pone triste
  SMINumber? numLook; //Sigue el texto del email

  bool _obscureText = true; // 👀 estado para mostrar/ocultar contraseña

  // 👉 Aquí van tus FocusNodes
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        if (isChecking != null) isChecking!.change(true);
        if (isHandsUp != null) isHandsUp!.change(false);
      } else {
        if (isChecking != null) isChecking!.change(false);
      }
    });

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        if (isHandsUp != null) isHandsUp!.change(true);
        if (isChecking != null) isChecking!.change(false);
      } else {
        if (isHandsUp != null) isHandsUp!.change(false);
      }
    });
  }

  @override
    void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailIdleTimer?.cancel(); // 🔹 cancelar timer si queda activo
    super.dispose();
  }

  void _validateLogin() {
  final email = _emailController.text.trim();
  final password = _passwordController.text;

  if (trigSuccess == null || trigFail == null) return;

  if (email == 'test@example.com' && password == '123456') {
    trigSuccess!.fire(); // Login correcto
  } else {
    trigFail!.fire();    // Login incorrecto
  }
}


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
                child: RiveAnimation.asset(
                  'animated_login_character.riv', 
                  stateMachines: ["Login Machine"],
                  //Configuración inicial
                  onInit: (artboard){
                    controller = StateMachineController.fromArtboard(
                      artboard, 
                      "Login Machine",
                      );
                      //Verifica si hay un controlador
                      if(controller == null) return;
                      //Agregar el controlador al tablero
                      artboard.addController(controller!);

                      isChecking = controller!.findSMI('isChecking');
                      isHandsUp = controller!.findSMI('isHandsUp');
                      trigSuccess = controller!.findSMI('trigSuccess');
                      trigFail = controller!.findSMI('trigFail');
                      numLook = controller!.findSMI('numLook');
                  },
                ),
              ),

                //Espacio entre la animacion y el texto
                const SizedBox(height: 10,),
                TextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  onChanged: (value) {
                    if (isHandsUp != null){
                      //No subir las manos al escribir email
                      isHandsUp!.change(false);
                    }
                    //Verifica que este SMI no sea nulo
                    if (isChecking == null)return;
                      isChecking!.change(true);
                    
                    if (numLook != null){
                      numLook!.value = (value.length / 3).clamp(0, 100).toDouble();
                    }
                     _emailIdleTimer?.cancel(); // cancela el anterior
                     _emailIdleTimer = Timer(const Duration(seconds: 2), () {
                        // Después de 2 segundos de inactividad
                        if (isChecking != null) isChecking!.change(false);
                      });
                  },
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

                const SizedBox(height: 10,),
                TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  onChanged: (value) {
                    if (isChecking != null){
                      //No mover ojos al escribir email
                      isChecking!.change(false);
                    }
                    //Verifica que este SMI no sea nulo
                    if (isHandsUp == null)return;
                    isHandsUp!.change(true);
                  },
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
                ),
                
                //Botón de login
                const SizedBox(height:10),
                MaterialButton(
                  minWidth: size.width,
                  height: 50,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: _validateLogin,
                     // solo ejemplo},
                  child: const Text("Login",
                  style:TextStyle(color: Colors.white) 
                  ),
                ),
                
                const SizedBox(height: 10),
                SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, //Centrar el texto
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: (){}, 
                        child: const Text("Register",
                          style: TextStyle(
                            color: Colors.black,
                            //Negritas
                            fontWeight: FontWeight.bold,
                            //Subrayado
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
             ],
          ),
        ),
      ),
    );
  }
}

