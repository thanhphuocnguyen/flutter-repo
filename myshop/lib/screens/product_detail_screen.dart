import 'package:flutter/material.dart';
import 'package:myshop/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings;
    final args = routeArgs.arguments as Map<String, dynamic>;
    final String id = args['id'];
    final String title = args['title'];
    final productDetail =
        Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      // appBar: AppBar(title: Text('$title #$id')),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('$title #$id'),
                background: Hero(
                  tag: productDetail.id,
                  child: Image.network(
                    productDetail.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '\$ ${productDetail.price}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      productDetail.description,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(
                    height: 800,
                  )
                ],
              ),
            )
          ],
          // child: Column(
          //   children: <Widget>[
          //     Container(
          //       margin: const EdgeInsets.all(15),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(15),
          //           border: Border.all(color: Colors.grey, width: 1.2)),
          //       padding: const EdgeInsets.symmetric(horizontal: 15),
          //       height: 300,
          //       width: double.infinity,
          //       child:
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
