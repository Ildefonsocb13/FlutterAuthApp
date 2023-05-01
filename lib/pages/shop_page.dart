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

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          //Search bar
          Container(
            padding: const EdgeInsets.all(12),
            margin:
                const EdgeInsets.symmetric(horizontal: 25),
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

          //Message
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Ahorrar no es solo guardar, sino saber gastar',
              style: TextStyle(color: Colors.grey),
            ),
          ),

          //Hot picks
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

          Expanded(
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                //get a product from shop list
                Producto producto =
                    value.getListaProductos()[index];
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
        ],
      ),
    );
  }
}
