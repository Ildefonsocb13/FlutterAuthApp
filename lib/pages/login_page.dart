import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';
import 'package:modernlogintute/components/square_tile.dart';
import 'package:modernlogintute/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    //Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //Try Sign in
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //Navigator.pop(context);
      //pop the loading circle
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //Wrong Email
      if (e.code == 'user-not-found') {
        showErrorMessage('Correo Incorrecto');
        print(
            'No se ha encontrado un usuario para ese correo');
      }
      //Wrong Password
      else if (e.code == 'wrong-password') {
        showErrorMessage('Contrasena Incorrecta');
        print('La contrasena es incorrecta');
      }
      //Invalid email
      else if (e.code == 'invalid-email') {
        showErrorMessage('Correo invalido');
        print('El correo es invalido');
      }
      //Disabled email
      else if (e.code == 'user-disabled') {
        showErrorMessage('Usuario desactivado');
        print('El usuario fue desaactivado');
      }
    }
    Navigator.pop(context);
  }

  //Wrong Email
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              message,
              style:
                  const TextStyle(color: Colors.lightBlue),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 133, 198, 244),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              SquareTile(
                  onTap: () {},
                  imagePath: 'lib/images/Logo1.png'),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              const Text(
                'Aqui estas! Hiciste falta',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 249, 249),
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Contrasena',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Olvidaste contrasena?',
                      style: TextStyle(
                          color: Color.fromARGB(
                              255, 255, 249, 249)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: signUserIn,
                text: 'Iniciar Sesion',
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Color.fromARGB(
                            255, 255, 249, 249),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0),
                      child: Text(
                        'Tambien puedes con...',
                        style: TextStyle(
                            color: Color.fromARGB(
                                255, 255, 249, 249)),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Color.fromARGB(
                            255, 255, 249, 249),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(
                      onTap: () =>
                          AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png'),

                  SizedBox(width: 25),

                  // apple button
                  SquareTile(
                      onTap: () {},
                      imagePath: 'lib/images/apple.png')
                ],
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No eres miembro?',
                    style: TextStyle(
                        color: Color.fromARGB(
                            255, 255, 249, 249)),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Registrate Ahora',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
