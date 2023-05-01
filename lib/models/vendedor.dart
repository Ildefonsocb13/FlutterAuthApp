class Vendedor {
  String idVendedor;
  String nombre;
  String empresa;
  String ubicacion;

  Vendedor({
    required this.idVendedor,
    required this.nombre,
    required this.empresa,
    required this.ubicacion,
  });

  factory Vendedor.fromMap(Map<String, dynamic> map) {
    return Vendedor(
      idVendedor: map['idVendedor'] as String,
      nombre: map['nombre'] as String,
      empresa: map['empresa'] as String,
      ubicacion: map['ubicacion'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idVendedor': idVendedor,
      'nombre': nombre,
      'empresa': empresa,
      'ubicacion': ubicacion,
    };
  }
}
