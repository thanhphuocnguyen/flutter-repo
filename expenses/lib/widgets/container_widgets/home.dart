import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/widgets/container_widgets/landscape_mode.dart';
import 'package:personal_expenses/widgets/container_widgets/potrait_mode.dart';

class Home extends StatefulWidget {
  final double appBarHeight;
  final List<Transaction> recentTransactions;
  final List<Transaction> transactions;
  final Function onDeleteTransaction;

  const Home(
      {Key? key,
      required this.appBarHeight,
      required this.recentTransactions,
      required this.transactions,
      required this.onDeleteTransaction})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLanscapeMode = mediaQuery.orientation == Orientation.landscape;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: isLanscapeMode
            ? LandscapeMode(
                appBarHeight: widget.appBarHeight,
                recentTransactions: widget.recentTransactions,
                transactions: widget.transactions,
                onDeleteTransaction: widget.onDeleteTransaction,
                mediaQuery: mediaQuery,
              )
            : PotraitMode(
                appBarHeight: widget.appBarHeight,
                recentTransactions: widget.recentTransactions,
                onDeleteTransaction: widget.onDeleteTransaction,
                transactions: widget.transactions,
                mediaQuery: mediaQuery,
              ),
      ),
    );
  }
}
