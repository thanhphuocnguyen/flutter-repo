// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/products.dart';
import 'package:myshop/screens/cart_screen.dart';
import 'package:myshop/widgets/badge.dart';
import 'package:myshop/widgets/drawer.dart';
import 'package:myshop/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum ProductFilters { Favourite, All }

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/products';
  const ProductOverviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

var _isInit = true;
var _isLoading = false;
var _isFavouriteFilter = false;

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  void onChangeFilter(ProductFilters value) {
    setState(() {
      if (value == ProductFilters.Favourite) {
        _isFavouriteFilter = true;
      } else {
        _isFavouriteFilter = false;
      }
    });
  }

  @override
  void initState() {
    //! HACKKKKKK!
    // Future.delayed(
    //     Duration.zero, Provider.of<Products>(context).fetchandSetProducts);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // if (mounted && _isInit) {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Products>(context).fetchandSetProducts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    // }
    // _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My shop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (ProductFilters value) => onChangeFilter(value),
            itemBuilder: ((context) => [
                  const PopupMenuItem(
                    value: ProductFilters.Favourite,
                    child: Text(
                      'Only favourite',
                    ),
                  ),
                  const PopupMenuItem(
                    value: ProductFilters.All,
                    child: Text('Show all'),
                  )
                ]),
          ),
          Consumer<Cart>(
            builder: (_, cartData, child) => Badge(
              value: cartData.itemCount.toString(),
              color: Colors.indigo.shade400,
              child: child!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: (() {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              }),
            ),
          )
        ],
      ),
      drawer: const SideDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(isFavourite: _isFavouriteFilter),
    );
  }
}
