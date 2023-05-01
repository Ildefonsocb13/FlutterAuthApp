import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/models/producto.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final CollectionReference productosCollection =
      FirebaseFirestore.instance.collection('productos');

  Future<void> agregarProductos(String texto) async {
    final firestoreService = FirestoreService();

    for (final producto in productoShop) {
      producto.imagen = texto;
      await firestoreService.productosCollection
          .doc(producto.id)
          .set(producto.toMap());
    }
  }

  Future<void> agregarProducto() async {
    final firestoreService = FirestoreService();

    for (final producto in productoShop) {
      await firestoreService.productosCollection
          .doc(producto.id)
          .set(producto.toMap());
    }
  }

  Future<String> subirImagen(
      File imageFile, String nombre) async {
    // Crea una referencia al archivo en Firebase Storage
    Reference referencia = FirebaseStorage.instance
        .ref()
        .child('imagenes')
        .child(nombre);

    print(File);

    // Sube el archivo a Firebase Storage
    TaskSnapshot snapshot =
        await referencia.putFile(imageFile);

    // Retorna la URL de descarga de la imagen
    return await snapshot.ref.getDownloadURL();
  }

  File getPath() {
    File imageFile = File('lib/images/oreos.png');
    return imageFile;
  }

  String getNombre() {
    return 'tele.jpg';
  }

  List<Producto> productoShop = [
    Producto(
      id: '8',
      nombre: 'Tele 2k',
      nombreEmpresa: 'Samsung',
      idVendedor: '3',
      descripcion: 'otra tele',
      precio: '5000',
      imagen: 'lib/images/tele.jpg',
    ),
  ];
}
