import 'package:flutter/material.dart';
import 'package:myshop/providers/products.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:myshop/widgets/drawer.dart';
import 'package:myshop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    UserProductItem(
                      imageUrl: products.items[index].imageUrl,
                      title: products.items[index].title,
                      id: products.items[index].id,
                    ),
                    const Divider()
                  ],
                ),
                itemCount: products.items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
