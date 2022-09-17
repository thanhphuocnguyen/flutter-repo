import 'package:flutter/material.dart';
import 'package:myshop/providers/products.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatefulWidget {
  const UserProductItem(
      {Key? key, required this.imageUrl, required this.title, required this.id})
      : super(key: key);
  final String title;
  final String imageUrl;
  final String id;

  @override
  State<UserProductItem> createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem> {
  void onDeleteUserProduct(BuildContext context, String prodId,
      ScaffoldMessengerState scaffold) async {
    setState(() {});
    try {
      await Provider.of<Products>(context, listen: false)
          .removeProductWhere(prodId);
      scaffold.showSnackBar(SnackBar(
        content: const Text('Successfully!'),
        backgroundColor: Colors.greenAccent.shade400,
      ));
    } catch (err) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                contentTextStyle:
                    TextStyle(color: Theme.of(context).errorColor),
                title: const Text('An error occurs!'),
                content:
                    const Text('Something went wrong. Try this action later.'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ok'))
                ],
              ));
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(widget.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: widget.id);
            },
            icon: const Icon(Icons.edit),
            color: Colors.green.shade500,
          ),
          IconButton(
            onPressed: () {
              onDeleteUserProduct(context, widget.id, scaffold);
            },
            icon: const Icon(Icons.delete),
            color: Colors.red.shade500,
          ),
        ],
      ),
    );
  }
}
