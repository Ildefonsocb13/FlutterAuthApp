import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modernlogintute/components/Bottom_nav_bar.dart';
import 'package:modernlogintute/pages/shop_page.dart';
import 'package:provider/provider.dart';

import '../components/uploadProduct.dart';
import '../models/cart.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  State<HomePage> createState() => _homePageState();
}

class _homePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  //SignUserOut
  void signUserOut() {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }

  //Metodo para actualizar el indice
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //paginas a desplegar
  final List<Widget> _pages = [
    //Pagina de Tienda
    ShopPage(),

    //Pagina de Carrito
    CartPage(),
  ];

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    final User? currentUser =
        FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser != user) {
      // El usuario ha cambiado, actualizar el carrito
      Provider.of<Cart>(context, listen: false)
          .cargarCarritoUsuario();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  //logo
                  DrawerHeader(
                      child: Image.asset(
                          'lib/images/Logo1.png')),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25),
                    child: Divider(
                      color: Colors.grey[800],
                    ),
                  ),

                  //Other Pages
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      leading: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.white),
                      title: Text(
                        user.email!,
                        style:
                            TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      leading: Icon(Icons.home_rounded,
                          color: Colors.white),
                      title: Text(
                        'Home',
                        style:
                            TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      leading: const Icon(Icons.info,
                          color: Colors.white),
                      title: const Text(
                        'Sobre Nosotros',
                        style:
                            TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        FirestoreService firestoreService =
                            FirestoreService();
                        firestoreService.agregarProductos();
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, bottom: 25),
                    child: ListTile(
                      leading: const Icon(
                          Icons.logout_rounded,
                          color: Colors.white),
                      title: const Text(
                        'Cerrar Sesion',
                        style:
                            TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        signUserOut();
                      },
                    ),
                  ),
                ],
              ),
            ]),
      ),
      body: _pages[_selectedIndex],
    );
  }
}



  /* Codigo para cargar imagenes de firebase
    onPressed: () async {
    final results = await FilePicker.platform.pickFiles(
    allowMultiple: false,

type: FileType.custom,
    allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (results == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
      content: Text("No file has been selected."),
      ),
    );
    return null;
    }
    final path = results.files.single.path;
    final fileName = results.files.single.name;
    storage
      .uploadFile(path!, fileName)
      .then((value) => print('Done'));
    print(path);
    print(fileName);
},
  */