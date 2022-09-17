import 'package:flutter/material.dart';
import 'package:myshop/providers/auth.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/order.dart';
import 'package:myshop/providers/products.dart';
import 'package:myshop/screens/auth_screen.dart';
import 'package:myshop/screens/cart_screen.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:myshop/screens/order_screen.dart';
import 'package:myshop/screens/product_detail_screen.dart';
import 'package:myshop/screens/product_overview_screen.dart';
import 'package:myshop/screens/splash_screen.dart';
import 'package:myshop/screens/user_product.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return Auth();
        }),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: ((_) => Products(null, [], null)),
            update: (context, auth, previousProducts) => Products(
                auth.token,
                previousProducts == null ? [] : previousProducts.items,
                auth.userId)),
        ChangeNotifierProvider(create: (_) {
          return Cart();
        }),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: (_) {
            return Order(
              null,
              [],
              null,
            );
          },
          update: ((context, auth, previousOrder) => Order(auth.token,
              previousOrder == null ? [] : previousOrder.order, auth.userId)),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, _) => MaterialApp(
          title: 'My shop',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
                .copyWith(secondary: Colors.orangeAccent),
            primaryTextTheme: TextTheme(
                headline6: TextStyle(color: Colors.red.shade400),
                button: TextStyle(color: Colors.blueGrey.shade800)),
          ),
          home: authData.isAuth
              ? const ProductOverviewScreen()
              : FutureBuilder(
                  future: authData.autoLogin(),
                  builder: ((context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen()),
                ),
          routes: {
            ProductDetailScreen.routeName: (context) =>
                const ProductDetailScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrderScreen.routeName: (context) => const OrderScreen(),
            UserProductScreen.routeName: (context) => const UserProductScreen(),
            EditProductScreen.routeName: (context) => const EditProductScreen(),
            ProductOverviewScreen.routeName: (context) =>
                const ProductOverviewScreen(),
          },
        ),
      ),
    );
  }
}
