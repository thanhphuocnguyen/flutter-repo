import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/widgets/component_widgets/chart.dart';
import 'package:personal_expenses/widgets/component_widgets/list_transactions.dart';

class LandscapeMode extends StatefulWidget {
  final double appBarHeight;
  final List<Transaction> recentTransactions;
  final List<Transaction> transactions;
  final Function onDeleteTransaction;
  final MediaQueryData mediaQuery;
  const LandscapeMode({
    Key? key,
    required this.appBarHeight,
    required this.recentTransactions,
    required this.transactions,
    required this.onDeleteTransaction,
    required this.mediaQuery,
  }) : super(key: key);

  @override
  State<LandscapeMode> createState() => _LandscapeModeState();
}

class _LandscapeModeState extends State<LandscapeMode> {
  bool _showChart = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = widget.mediaQuery;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Show chart",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Switch.adaptive(
                value: _showChart,
                onChanged: (value) => setState(() {
                      _showChart = value;
                    }))
          ],
        ),
        _showChart
            ? Container(
                height: (mediaQuery.size.height -
                        widget.appBarHeight -
                        mediaQuery.padding.top) *
                    0.8,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Chart(recentTransaction: widget.recentTransactions))
            : SizedBox(
                height: (mediaQuery.size.height -
                        widget.appBarHeight -
                        mediaQuery.padding.top) *
                    0.9,
                child: TransactionList(
                  key: const Key("list"),
                  transactions: widget.transactions,
                  onDeleteTransaction: widget.onDeleteTransaction,
                ),
              )
      ],
    );
  }
}
