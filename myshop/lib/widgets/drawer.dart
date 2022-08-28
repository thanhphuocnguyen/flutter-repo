import 'package:flutter/material.dart';
import 'package:myshop/screens/order_screen.dart';
import 'package:myshop/screens/user_product.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Hello!'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Orders'),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.view_list_outlined),
          title: const Text('Personal Products'),
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(UserProductScreen.routeName),
        ),
      ]),
    );
  }
}
