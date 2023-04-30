import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/producto.dart';

class ProductoCarrito extends StatefulWidget {
  Producto producto;
  ProductoCarrito({
    super.key,
    required this.producto,
  });

  @override
  State<ProductoCarrito> createState() =>
      _ProductoCarritoState();
}

class _ProductoCarritoState extends State<ProductoCarrito> {
  bool _isChecked = false;
  int _counter = 1;

  //Remover produto del carrito
  void quitarProductoDelCarrito() {
    Provider.of<Cart>(context, listen: false)
        .quitarProductoDelCarrito(widget.producto);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Row(
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
              checkColor: Colors.green,
              activeColor: Colors.transparent,
              side: BorderSide(color: Colors.grey),
              shape: CircleBorder(),
            ),
            Image.asset(
              widget.producto.imagen,
              width: 50,
              height: 50,
            ),
            SizedBox(width: 8),
            Text('\$${widget.producto.precio}   '),
            Text(widget.producto.nombre),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_rounded),
          onPressed: quitarProductoDelCarrito,
        ),
      ),
    );
  }
}
