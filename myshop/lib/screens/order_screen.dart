import 'package:flutter/material.dart';
import 'package:myshop/providers/order.dart';
import 'package:myshop/widgets/drawer.dart';
import 'package:myshop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Order>(context, listen: false).order;

    return Scaffold(
      appBar: AppBar(title: const Text('Order')),
      drawer: const SideDrawer(),
      body: ListView.builder(
        itemBuilder: ((context, index) =>
            OrderItemWidget(order: orders[index])),
        itemCount: orders.length,
      ),
    );
  }
}
