import 'package:flutter/material.dart';
import 'package:modernlogintute/models/producto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart extends ChangeNotifier {
  final CollectionReference _carroRef =
      FirebaseFirestore.instance.collection('carritos');
  User? _usuarioActual = FirebaseAuth.instance.currentUser;

  List<Producto> _carritoUsuario = [];
  List<Producto> get carritoUsuario => _carritoUsuario;

  set carritoUsuario(List<Producto> value) {
    _carritoUsuario = value;
    actualizarCarritoFirestore();
    notifyListeners();
  }

  Cart() {
    cargarCarritoUsuario().then((productosCarrito) {
      _carritoUsuario = productosCarrito;
      notifyListeners();
    });
    cargarProductos().then((productos) {
      productoShop = productos;
      notifyListeners();
    });
  }

  //Cargar carro del usuario desde Firestore
  Future<List<Producto>> cargarCarritoUsuario() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot carritoSnapshot =
        await FirebaseFirestore.instance
            .collection('carritos')
            .doc(userId)
            .get();

    Map<String, dynamic> carritoData =
        (carritoSnapshot.data() as Map<String, dynamic>?) ??
            {};
    // Add null check here

    List<dynamic> productosData =
        carritoData['productos'] ??
            []; // Add null check here

    List<Producto> productosCarrito = productosData
        .map((productoData) => Producto.fromMap(
            productoData as Map<String, dynamic>))
        .toList();

    print('ID del usuario: $userId');
    print('Productos en el carrito:');
    productosCarrito.forEach((producto) {
      print('- ${producto.nombre}');
    });

    return productosCarrito;
  }

  //Actualizar el carrito en Firestore
  Future<void> actualizarCarritoFirestore() async {
    if (_usuarioActual != null) {
      print('llega de parametro: ${_usuarioActual?.uid}');
      _usuarioActual = FirebaseAuth.instance.currentUser;
      String userId =
          FirebaseAuth.instance.currentUser!.uid;
      print('Se cambia a: ${_usuarioActual?.uid}');
      List<Map<String, dynamic>> productosMap =
          _carritoUsuario
              .map((producto) => producto.toMap())
              .toList();
      await _carroRef.doc(_usuarioActual?.uid).set(
          {'productos': productosMap},
          SetOptions(merge: true));

      // Print ID del usuario y los productos en el carrito
      print('Usuario actual: $userId');
      print('Productos en el carrito:');
      _carritoUsuario.forEach((producto) {
        print('- ${producto.nombre}');
      });
    }
  }

  //get list of products for sale
  List<Producto> productoShop = [];

  List<Producto> getListaProductos() {
    return productoShop;
  }

  //get cart
  List<Producto> getCarritoUsuario() {
    return _carritoUsuario;
  }

  //add items to cart
  Future<void> agregarProductoAlCarrito(
      Producto producto) async {
    _usuarioActual = FirebaseAuth.instance.currentUser;

    _carritoUsuario.add(producto);
    await actualizarCarritoFirestore();
    notifyListeners();
  }

  //remove item from cart
  Future<void> quitarProductoDelCarrito(
      Producto producto) async {
    _carritoUsuario.remove(producto);
    await actualizarCarritoFirestore();
    notifyListeners();
  }

  String calcularTotal() {
    double precioTotal = 0;
    for (var i = 0; i < _carritoUsuario.length; i++) {
      precioTotal +=
          double.parse(_carritoUsuario[i].precio);
    }
    return precioTotal.toStringAsFixed(2);
  }

  Future<List<Producto>> cargarProductos() async {
    final QuerySnapshot productosSnapshot =
        await FirebaseFirestore.instance
            .collection('productos')
            .get();

    final List<Producto> productos = productosSnapshot.docs
        .map((productoDoc) => Producto.fromMap(
            productoDoc.data() as Map<String, dynamic>))
        .toList();

    return productos;
  }
}
