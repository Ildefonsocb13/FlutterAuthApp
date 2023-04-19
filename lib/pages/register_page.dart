import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';
import 'package:modernlogintute/components/square_tile.dart';
import 'package:modernlogintute/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user up method
  void signUserUp() async {
    //Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //Try creating the user
    try {
      //Check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //pop the loading circle
        Navigator.pop(context);
      } else {
        //pop the loading circle
        Navigator.pop(context);
        //Show error message, passwords dont match
        showErrorMessage('Las contrasenas son distintas!');
      }
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);

      //Email already exists
      if (e.code == 'email-already-in-use') {
        showErrorMessage('Correo ya existente');
        print('Ya se encontro usuario con ese correo');
      }

      //Invalid email
      else if (e.code == 'invalid-email') {
        showErrorMessage('Correo invalido');
        print('El correo es invalido');
      }

      //Operation not allowed
      else if (e.code == 'operation-not-allowed') {
        showErrorMessage('Correo/Contra no permitidos');
        print('Correo/Contra no permitidos');
      }

      //Weak Password
      else if (e.code == 'weak-password') {
        showErrorMessage('Contrasena es debil');
        print('Contrasena debil');
      }
    }
  }

  //Wrong message
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.lightBlue),
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
              const SizedBox(height: 25),

              // logo
              SquareTile(onTap: () {}, imagePath: 'lib/images/Logo1.png'),

              const SizedBox(height: 25),

              // Bienvenido, crea una cuenta!
              const Text(
                'Bienvenido, crea una cuenta!',
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

              // confirm password textfield
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirma Contrasena',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: signUserUp,
                text: 'Registrarse',
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Color.fromARGB(255, 255, 249, 249),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'O continua con...',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 249, 249)),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Color.fromARGB(255, 255, 249, 249),
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
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png'),

                  SizedBox(width: 25),

                  // apple button
                  SquareTile(onTap: () {}, imagePath: 'lib/images/apple.png')
                ],
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ya eres miembro?',
                    style: TextStyle(color: Color.fromARGB(255, 255, 249, 249)),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Iniciar Ahora',
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
