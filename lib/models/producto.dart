import 'package:modernlogintute/models/vendedor.dart';

class Producto {
  final String id;
  final String nombre;
  final String nombreEmpresa;
  final String idVendedor;
  final String descripcion;
  final String precio;
  final String imagen;

  Producto({
    required this.id,
    required this.nombre,
    required this.nombreEmpresa,
    required this.idVendedor,
    required this.descripcion,
    required this.precio,
    required this.imagen,
  });

  // Método fromMap para convertir un objeto Map en una instancia de Producto
  static Producto fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      nombre: map['nombre'],
      nombreEmpresa: map['nombreEmpresa'],
      idVendedor: map['vendedor'],
      descripcion: map['descripcion'],
      precio: map['precio'],
      imagen: map['imagen'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'nombreEmpresa': nombreEmpresa,
      'vendedor': idVendedor,
      'descripcion': descripcion,
      'precio': precio,
      'imagen': imagen,
    };
  }
}
