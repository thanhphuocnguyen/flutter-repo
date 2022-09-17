import 'package:flutter/material.dart';
import 'package:myshop/providers/auth.dart';
import 'package:myshop/screens/order_screen.dart';
import 'package:myshop/screens/user_product.dart';
import 'package:provider/provider.dart';

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
        const Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Logout'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/');
            Provider.of<Auth>(context, listen: false).logout();
          },
        ),
      ]),
    );
  }
}
