import 'package:flutter/material.dart';
import 'package:modernlogintute/models/producto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart extends ChangeNotifier {
  //list of shoes for sale
  List<Producto> productoShop = [
    Producto(
      id: '1',
      nombre: 'Coca Cola',
      nombreEmpresa: 'Coca Cola Company',
      descripcion: 'estee una coca de 600ml',
      precio: '16',
      imagen: 'lib/images/coca-cola.jpg',
    ),
    Producto(
      id: '2',
      nombre: 'Chips2',
      nombreEmpresa: 'Barcel',
      descripcion: 'papitas sabor fuegoo',
      precio: '40',
      imagen: 'lib/images/chips_fuego.jpg',
    ),
    Producto(
      id: '3',
      nombre: 'Chips3',
      nombreEmpresa: 'Barcel',
      descripcion: 'papitas sabor fuegoo',
      precio: '40',
      imagen: 'lib/images/chips_fuego.jpg',
    ),
    Producto(
      id: '4',
      nombre: 'Chips4',
      nombreEmpresa: 'Barcel',
      descripcion: 'papitas sabor fuegoo',
      precio: '40',
      imagen: 'lib/images/chips_fuego.jpg',
    ),
    Producto(
      id: '5',
      nombre: 'Chips5',
      nombreEmpresa: 'Barcel',
      descripcion: 'papitas sabor fuegoo',
      precio: '40',
      imagen: 'lib/images/chips_fuego.jpg',
    ),
  ];

  //list of items in user cart
  List<Producto> carritoUsuario = [];

  //get list of shoes for sale

  List<Producto> getListaProductos() {
    return productoShop;
  }

  //get cart
  List<Producto> getCarritoUsuario() {
    return carritoUsuario;
  }

  //add items to cart
  void agregarProductoAlCarrito(Producto producto) {
    carritoUsuario.add(producto);
    notifyListeners();
  }

  //remove item from cart
  void quitarProductoDelCarrito(Producto producto) {
    carritoUsuario.remove(producto);
    notifyListeners();
  }

  String calcularTotal() {
    double precioTotal = 0;
    for (var i = 0; i < carritoUsuario.length; i++) {
      precioTotal += double.parse(carritoUsuario[i].precio);
    }
    return precioTotal.toStringAsFixed(2);
  }
}
