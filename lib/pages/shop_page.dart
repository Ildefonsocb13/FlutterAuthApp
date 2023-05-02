import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modernlogintute/models/cart.dart';
import 'package:modernlogintute/models/producto.dart';
import 'package:modernlogintute/pages/search_page.dart';
import 'package:provider/provider.dart';
import '../components/mejoresOfertas.dart';

class ShopPage extends StatefulWidget {
  const ShopPage(
      {super.key}); // Constructor de la clase ShopPage

  @override
  State<ShopPage> createState() =>
      _ShopPageState(); // Creamos el estado de la página
}

class _ShopPageState extends State<ShopPage> {
  // Método para agregar un producto al carrito
  void agregarProductoAlCarrito(Producto producto) {
    Provider.of<Cart>(context, listen: false)
        .agregarProductoAlCarrito(
            producto); // Usamos la clase Cart y su método agregarProductoAlCarrito() para agregar el producto al carrito
    // Mostramos un mensaje de confirmación al usuario
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Agregado Correctamente'),
        content: Text('Checa tu Carrito'),
      ),
    );
  }

  final Random _random =
      Random(); // Creamos una instancia de la clase Random
  final List<String> _messages = [
    'Ahorrar no es solo guardar, sino saber gastar',
    'Ahorra para lo que realmente importa',
    'El ahorro no es sacrificio, es inversión en tu futuro',
  ]; // Creamos una lista de mensajes

  String _getRandomMessage() {
    return _messages[_random.nextInt(_messages
        .length)]; // Obtenemos un mensaje aleatorio de la lista
  }

  int countProductsById(
      String id, List<Producto> productos) {
    return productos
        .where((producto) => producto.idVendedor == id)
        .length; // Contamos la cantidad de productos que pertenecen a un vendedor específico
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
            // Barra de búsqueda
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 2, horizontal: 25),
              margin: const EdgeInsets.symmetric(
                  horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Buscar',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search_rounded,
                      color: Colors.grey),
                ),
                textAlignVertical: TextAlignVertical.center,
                onSubmitted: (value) {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SearchPage(
                              searchText: value))));*/
                  // Aquí puedes realizar la búsqueda con el valor ingresado
                  print('Buscando $value');
                },
              ),
            ),

            // Mensaje aleatorio
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
