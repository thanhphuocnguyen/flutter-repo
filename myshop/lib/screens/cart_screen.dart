import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/order.dart';
import 'package:myshop/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/cart-page';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final listItem = cartData.item.values.toList();
    final listId = cartData.item.keys.toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$ ${cartData.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: cartData.itemCount <= 0 || _isLoading
                        ? null
                        : (() async {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await Provider.of<Order>(context, listen: false)
                                  .addOrder(listItem, cartData.totalPrice);
                              cartData.clearCart();
                            } catch (err) {
                              print(err);
                              await showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        contentTextStyle: TextStyle(
                                            color:
                                                Theme.of(context).errorColor),
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
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }),
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                ?.color)),
                    child: const Text(
                      'Order now',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cartData.item.length,
            itemBuilder: ((context, index) => CartItemWidget(
                  key: ValueKey('product-${listId[index]}'),
                  id: listId[index],
                  quantity: listItem[index].quantity,
                )),
          ))
        ],
      ),
    );
  }
}
