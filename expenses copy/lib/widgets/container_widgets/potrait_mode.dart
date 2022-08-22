import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/widgets/component_widgets/chart.dart';
import 'package:personal_expenses/widgets/component_widgets/list_transactions.dart';

class PotraitMode extends StatelessWidget {
  final double appBarHeight;
  final List<Transaction> recentTransactions;
  final List<Transaction> transactions;
  final Function onDeleteTransaction;
  final MediaQueryData mediaQuery;

  const PotraitMode({
    Key? key,
    required this.appBarHeight,
    required this.recentTransactions,
    required this.onDeleteTransaction,
    required this.transactions,
    required this.mediaQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
            height: (mediaQuery.size.height -
                    appBarHeight -
                    mediaQuery.padding.top -
                    mediaQuery.padding.bottom) *
                0.3,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Chart(recentTransaction: recentTransactions)),
        SizedBox(
          height: (mediaQuery.size.height -
                  appBarHeight -
                  mediaQuery.padding.top -
                  mediaQuery.padding.bottom) *
              0.7,
          child: TransactionList(
            key: const Key("list"),
            transactions: transactions,
            onDeleteTransaction: onDeleteTransaction,
          ),
        ),
      ],
    );
  }
}
