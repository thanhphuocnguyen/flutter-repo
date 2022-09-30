import 'package:flutter/material.dart';

class DetailPlaceScreen extends StatelessWidget {
  static const routeName = '/detail-place';
  const DetailPlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add place'),
      ),
      body: Column(
        children: <Widget>[
          const Text('User Input...'),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add place'),
          )
        ],
      ),
    );
  }
}
