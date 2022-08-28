import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart';

import 'package:myshop/providers/products.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
    required this.id,
    required this.quantity,
  }) : super(key: key);
  final String id;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final productDetail = products.findById(id);
    return Dismissible(
      onDismissed: (direction) {
        cart.removeItem(id);
      },
      confirmDismiss: ((direction) => showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text('Are you sure to remove this item?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.red.shade500),
                    ),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    child: const Text('Yes'),
                  )
                ],
              )))),
      direction: DismissDirection.endToStart,
      key: key!,
      background: Container(
        color: Theme.of(context).errorColor,
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: const Icon(
          Icons.remove_circle,
          size: 40,
          color: Colors.white,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListTile(
            leading: FittedBox(
              child: CircleAvatar(
                radius: 15,
                child: Image.network(productDetail.imageUrl),
              ),
            ),
            title: Text('${productDetail.title}  x$quantity'),
            subtitle: Text('Unit price: ${productDetail.price}'),
            trailing: Text('Total: \$ ${quantity * productDetail.price}'),
          ),
        ),
      ),
    );
  }
}
