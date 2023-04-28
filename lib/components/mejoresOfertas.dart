import 'package:flutter/material.dart';
import 'package:modernlogintute/models/producto.dart';

class MejoresOfertas extends StatelessWidget {
  Producto producto;
  void Function()? onTap;
  MejoresOfertas({
    super.key,
    required this.producto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Imagen Producto
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(producto.imagen),
          ),
          //Descripcion
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              producto.descripcion,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          //Precio + detalles
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    //nombre producto
                    Text(
                      producto.nombre,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    //precio
                    Text(
                      '\$' + producto.precio,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                //Agregar
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Boton para agregar a Carrito
        ],
      ),
    );
  }
}
