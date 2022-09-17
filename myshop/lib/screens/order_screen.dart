import 'package:flutter/material.dart';
import 'package:myshop/providers/order.dart';
import 'package:myshop/widgets/drawer.dart';
import 'package:myshop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future _orderFuture;

  Future _obtainOrderFuture() {
    return Provider.of<Order>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order')),
      drawer: const SideDrawer(),
      body: FutureBuilder(
        future: _orderFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error == null) {
              return Consumer<Order>(
                  builder: ((context, orders, child) => ListView.builder(
                        itemBuilder: ((context, index) =>
                            OrderItemWidget(order: orders.order[index])),
                        itemCount: orders.order.length,
                      )));
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'An errors occurs!! Please check later',
                    style: TextStyle(
                        fontSize: 26, color: Theme.of(context).errorColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          }
        }),
      ),
    );
  }
}
