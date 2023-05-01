import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/models/producto.dart';

class FirestoreService {
  final CollectionReference productosCollection =
      FirebaseFirestore.instance.collection('productos');

  Future<void> agregarProductos() async {
    final firestoreService = FirestoreService();

    for (final producto in productoShop) {
      await firestoreService.productosCollection
          .doc(producto.id)
          .set(producto.toMap());
    }
  }

  List<Producto> productoShop = [
    Producto(
      id: '6',
      nombre: 'Tele 4kHD 3000 FPS',
      nombreEmpresa: 'Samsung',
      idVendedor: '1',
      descripcion: 'la mamalona',
      precio: '10000',
      imagen: 'lib/images/coca-cola.jpg',
    ),
  ];
}
