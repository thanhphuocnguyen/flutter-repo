import 'dart:io';

import "package:flutter/material.dart";
import 'package:intl/date_symbol_data_local.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/widgets/container_widgets/cupertino_tree.dart';
import 'package:personal_expenses/widgets/container_widgets/home.dart';
import 'package:personal_expenses/widgets/container_widgets/material_tree.dart';

void main() async {
  await initializeDateFormatting("vi", null);
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
  runApp(const MyApp());
  // });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _transactions = [
    Transaction(
        id: "t1",
        amount: 400000,
        timestamp: DateTime.now(),
        title: "Thức ăn hằng tuần"),
    Transaction(
        id: "t2",
        amount: 250000,
        timestamp: DateTime.now(),
        title: "Cà phê hằng tuần"),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) => element.timestamp
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _onAddTransaction(
      double amountControl, String titleControl, DateTime? timeStamp) {
    setState(() {
      _transactions.add(Transaction(
          id: DateTime.now().toString(),
          amount: amountControl,
          timestamp: timeStamp ?? DateTime.now(),
          title: titleControl));
    });
  }

  void _onDeleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final appBar =
    final home = Home(
        appBarHeight: 20,
        recentTransactions: _recentTransactions,
        transactions: _transactions,
        onDeleteTransaction: _onDeleteTransaction);
    return MaterialApp(
        home: Builder(
            builder: (context) => Platform.isIOS
                ? CupertinoTree(
                    home: home,
                    onAddTransaction: _onAddTransaction,
                  )
                : MaterialTree(
                    home: home, onAddTransaction: _onAddTransaction)));
  }
}
