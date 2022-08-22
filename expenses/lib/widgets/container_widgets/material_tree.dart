import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/component_widgets/new_transaction.dart';

class MaterialTree extends StatelessWidget {
  final Widget home;
  final Function onAddTransaction;
  MaterialTree({Key? key, required this.home, required this.onAddTransaction})
      : super(key: key);
  final AppBarTheme appBarTheme = const AppBarTheme(
    // toolbarTextStyle: TextStyle(
    //     fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold),
    titleTextStyle: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

  final ThemeData theme = ThemeData(
    errorColor: Colors.redAccent[700],
    primarySwatch: Colors.green,
    fontFamily: 'Quicksand',
    textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.purple[500],
          ),
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            color: Colors.purple[500],
            fontSize: 22,
          ),
          titleSmall: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            color: Colors.purple[500],
            fontSize: 14,
          ),

          // button: const TextStyle(color: Colors.white10),
        ),
  );

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(onAddTransaction: onAddTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.amberAccent),
        appBarTheme: appBarTheme,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Personal Expenses',
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
          body: home,
          floatingActionButton: FloatingActionButton(
            tooltip: "Create new transaction",
            highlightElevation: 5,
            onPressed: () => _startAddNewTransaction(context),
            child: const Icon(Icons.add),
          )),
    );
  }
}
