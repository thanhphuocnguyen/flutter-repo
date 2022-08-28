import 'package:flutter/material.dart';
import 'package:myshop/providers/products.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem(
      {Key? key, required this.imageUrl, required this.title, required this.id})
      : super(key: key);
  final String title;
  final String imageUrl;
  final String id;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id);
            },
            icon: const Icon(Icons.edit),
            color: Colors.green.shade500,
          ),
          IconButton(
            onPressed: () {
              Provider.of<Products>(context, listen: false)
                  .removeProductWhere(id);
            },
            icon: const Icon(Icons.delete),
            color: Colors.red.shade500,
          ),
        ],
      ),
    );
  }
}
