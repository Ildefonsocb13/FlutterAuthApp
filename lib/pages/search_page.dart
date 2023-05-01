import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/mejoresOfertas.dart';
import '../models/cart.dart';
import '../models/countResult.dart';
import '../models/producto.dart';

class SearchPage extends StatefulWidget {
  final String searchText;

  const SearchPage({super.key, required this.searchText});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //metodo para agregar el producto al Carrito
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

  //Escoge un mensaje aleatorio
  final Random _random = Random();
  final List<String> _messages = [
    'Ahorrar no es solo guardar, sino saber gastar',
    'Ahorra para lo que realmente importa',
    'El ahorro no es sacrificio, es inversión en tu futuro',
  ];

  //Obtiene el mensaje aleatorio
  String _getRandomMessage() {
    return _messages[_random.nextInt(_messages.length)];
  }

  String valorBuscado = '';

  //metodo para contar prodctos por idVendedor, para poder desplegar con un max de esa cantidad
  int countProductsByIdVendedor(
      String id, List<Producto> productos) {
    return productos
        .where((producto) => producto.idVendedor == id)
        .length;
  }

  //metodo para contar prodctos por idVendedor, para poder desplegar con un max de esa cantidad
  int countProductsByIdProducto(
      String id, List<Producto> productos) {
    return productos
        .where((producto) => producto.id == id)
        .length;
  }

  CountResult buscadorProductos(
      String id, List<Producto> productos) {
    if (countProductsByIdVendedor(id, productos) > 0) {
      return CountResult(0, 0);
    } else if (countProductsByIdProducto(id, productos) >
        0) {
      return CountResult(0, 1);
    }
    return CountResult(0, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<Cart>(
        builder: (context, value, child) {
          final CountResult countResult = buscadorProductos(
              valorBuscado, value.getListaProductos());
          final int count = countResult.count;
          final int index = countResult.count;
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                // Search bar
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
                      hintStyle:
                          TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search_rounded,
                          color: Colors.grey),
                    ),
                    textAlignVertical:
                        TextAlignVertical.center,
                    onSubmitted: (value) {
                      // Aquí puedes realizar la búsqueda con el valor ingresado
                      print('Buscando $value');
                    },
                  ),
                ),

                // Message
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 50),
                  child: Text(
                    _getRandomMessage(),
                    style:
                        const TextStyle(color: Colors.grey),
                  ),
                ),

                // Hot picks
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.end,
                    children: [
                      Text(
                        valorBuscado,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      const Text('Ver todo',
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
                    itemCount:
                        count /*countProductsByIdVendedor(
                    '1', value.getListaProductos())*/
                    ,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index <
                          countProductsByIdVendedor(
                              valorBuscado,
                              value.getListaProductos())) {
                        Producto producto = value
                            .getListaProductos()
                            .where((producto) =>
                                producto.idVendedor ==
                                valorBuscado)
                            .elementAt(index);
                        return MejoresOfertas(
                          producto: producto,
                          onTap: () =>
                              agregarProductoAlCarrito(
                                  producto),
                        );
                      } else if (index <
                          countProductsByIdProducto(
                              valorBuscado,
                              value.getListaProductos())) {
                        Producto producto = value
                            .getListaProductos()
                            .where((producto) =>
                                producto.id == valorBuscado)
                            .elementAt(index -
                                countProductsByIdVendedor(
                                    valorBuscado,
                                    value
                                        .getListaProductos()));
                        return MejoresOfertas(
                          producto: producto,
                          onTap: () =>
                              agregarProductoAlCarrito(
                                  producto),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
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
              ],
            ),
          );
        },
      ),
    );
  }
}
