import 'package:flutter/material.dart';
import 'package:myshop/providers/products.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:myshop/widgets/drawer.dart';
import 'package:myshop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);
  static const routeName = '/user-products';

  Future<void> onRefreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchandSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<Products>(context, listen: false);
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
      body: FutureBuilder(
        future: onRefreshProducts(context),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: (() => onRefreshProducts(context)),
                child: Consumer<Products>(
                  builder: ((context, productData, _) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: productData.items.isEmpty
                            ? const Center(
                                child: Text('You have no product here'),
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) => Column(
                                        children: [
                                          UserProductItem(
                                            imageUrl: productData
                                                .items[index].imageUrl,
                                            title:
                                                productData.items[index].title,
                                            id: productData.items[index].id,
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                      itemCount: productData.items.length,
                                    ),
                                  ),
                                ],
                              ),
                      )),
                ),
              ),
      ),
    );
  }
}
