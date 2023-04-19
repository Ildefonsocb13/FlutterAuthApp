import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  final user = FirebaseAuth.instance.currentUser!;

  //SignUserOut
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
      ),
      body: Center(
          child: Text(
        "Logged In As: " + user.email!,
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
