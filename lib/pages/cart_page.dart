import 'package:flutter/material.dart';
import 'package:modernlogintute/models/cart.dart';
import 'package:modernlogintute/models/producto.dart';
import 'package:provider/provider.dart';

import '../components/productoCarrito.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title
            const Text(
              'Mi carrito',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),

            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.getCarritoUsuario().length,
                itemBuilder: (context, index) {
                  //get individual Product
                  Producto productoIndividual =
                      value.getCarritoUsuario()[index];

                  //return the cart item
                  return ProductoCarrito(
                    producto: productoIndividual,
                  );
                },
              ),
            ),

            //Precio Total
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                padding: EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Text('Precio Total',
                            style: const TextStyle(
                                fontSize: 24)),
                        Text(
                          '\$${value.calcularTotal()}',
                          style:
                              const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
