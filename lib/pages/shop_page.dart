import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modernlogintute/models/cart.dart';
import 'package:modernlogintute/models/producto.dart';
import 'package:provider/provider.dart';
import '../components/mejoresOfertas.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  //add product to cart
  void agregarProductoAlCarrito(Producto producto) {
    Provider.of<Cart>(context, listen: false)
        .agregarProductoAlCarrito(producto);
    //alert the user, product succesfully added
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Agregado Correctamente'),
        content: Text('Checa tu Carrito'),
      ),
    );
  }

  final Random _random = Random();
  final List<String> _messages = [
    'Ahorrar no es solo guardar, sino saber gastar',
    'Ahorra para lo que realmente importa',
    'El ahorro no es sacrificio, es inversión en tu futuro',
  ];

  String _getRandomMessage() {
    return _messages[_random.nextInt(_messages.length)];
  }

  int countProductsById(
      String id, List<Producto> productos) {
    return productos
        .where((producto) => producto.idVendedor == id)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) =>
          SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(
                  horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Buscar',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(Icons.search_rounded,
                      color: Colors.grey),
                ],
              ),
            ),

            // Message
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 25.0, horizontal: 50),
              child: Text(
                _getRandomMessage(),
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            // Hot picks
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 25.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'Mejores Ofertas 🔥',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Text('Ver todo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: countProductsById(
                    '1', value.getListaProductos()),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  //get a product from shop list
                  Producto producto = value
                      .getListaProductos()
                      .where((producto) =>
                          producto.idVendedor == '1')
                      .elementAt(index);
                  //return the product
                  return MejoresOfertas(
                    producto: producto,
                    onTap: () =>
                        agregarProductoAlCarrito(producto),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  top: 25, left: 25, right: 25),
              child: Divider(
                color: Colors.white,
              ),
            ),

            // Segunda seccion
            // ...
            // filtro 1
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 25.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'Chedraui',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Text('Ver todo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: countProductsById(
                    '2', value.getListaProductos()),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  //get a product from shop list
                  Producto producto = value
                      .getListaProductos()
                      .where((producto) =>
                          producto.idVendedor == '2')
                      .elementAt(index);
                  //return the product
                  return MejoresOfertas(
                    producto: producto,
                    onTap: () =>
                        agregarProductoAlCarrito(producto),
                  );
                },
              ),
            ),

            //Divisor
            const Padding(
              padding: EdgeInsets.only(
                  top: 25, left: 25, right: 25),
              child: Divider(
                color: Colors.white,
              ),
            ),

            // Third section
            // ...
            // filtro 2
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 25.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'Walmart',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Text('Ver todo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: countProductsById(
                    '3', value.getListaProductos()),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  //get a product from shop list
                  Producto producto = value
                      .getListaProductos()
                      .where((producto) =>
                          producto.idVendedor == '3')
                      .elementAt(index);
                  //return the product
                  return MejoresOfertas(
                    producto: producto,
                    onTap: () =>
                        agregarProductoAlCarrito(producto),
                  );
                },
              ),
            ),

            //Divisor
            const Padding(
              padding: EdgeInsets.only(
                  top: 25, left: 25, right: 25),
              child: Divider(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
