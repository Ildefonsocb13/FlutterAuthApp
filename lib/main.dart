import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modernlogintute/models/cart.dart';
import 'package:modernlogintute/pages/auth_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Aseguramos que los widgets estén inicializados antes de continuar con la ejecución
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Inicializamos Firebase
  );
  runApp(const MyApp()); // Iniciamos la aplicación
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor de la clase MyApp

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          Cart(), // Creamos una instancia de la clase Cart para usar el patrón Provider
      builder: (context, child) => MaterialApp(
        // Creamos la interfaz de usuario de la aplicación
        debugShowCheckedModeBanner:
            false, // Ocultamos la etiqueta "Debug" en la aplicación
        key: ValueKey(
            // Asignamos una clave única a la aplicación para manejar la autenticación de Firebase
            FirebaseAuth.instance.currentUser?.uid),
        home:
            const AuthPage(), // Establecemos la página de autenticación como pantalla principal
      ),
    );
  }
}
