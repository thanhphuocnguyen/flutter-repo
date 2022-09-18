import 'package:flutter/material.dart';
import 'package:myshop/providers/auth.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/product.dart';
import 'package:myshop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: (() async {
                try {
                  await product.toggleFavourite(auth.token, auth.userId);
                  scaffoldMessenger.hideCurrentSnackBar();
                  scaffoldMessenger.showSnackBar(SnackBar(
                    content: const Text(
                      'Successful!!',
                      textAlign: TextAlign.center,
                    ),
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.green.shade500,
                  ));
                } catch (err) {
                  print(err);
                  await showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            contentTextStyle:
                                TextStyle(color: Theme.of(context).errorColor),
                            title: const Text('An error occurs!'),
                            content: const Text(
                                'Something went wrong. Try this action later.'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ok'))
                            ],
                          ));
                }
              }),
            ),
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart,
                color: Theme.of(context).colorScheme.secondary),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Added item ${product.title} to cart!'),
                duration: const Duration(seconds: 4),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.undoAddItem(product.id);
                  },
                ),
              ));
            },
          ),
        ),
        child: GestureDetector(
          onTap: (() => Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: {
                  'title': product.title,
                  'id': product.id,
                },
              )),
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: const AssetImage('assets/images/empty.png'),
              image: NetworkImage(
                product.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
