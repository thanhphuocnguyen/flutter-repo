import 'package:flutter/material.dart';
import 'package:myshop/providers/products.dart';
import 'package:myshop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key? key,
    required this.isFavourite,
  }) : super(key: key);
  final bool isFavourite;
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);

    final loadedProducts =
        isFavourite ? productsData.favouriteItems : productsData.items;
    return loadedProducts.isEmpty
        ? Center(
            child: Text(
              'There are no products',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: ((context, index) => ChangeNotifierProvider.value(
                  value: loadedProducts[index],
                  child: const ProductItem(),
                )),
            itemCount: loadedProducts.length,
          );
  }
}
