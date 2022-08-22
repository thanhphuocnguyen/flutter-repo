import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onDeleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function onDeleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  final f = NumberFormat("###,###", "en_US");
  late Color _bgColor;
  @override
  void initState() {
    const bgColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.yellow,
      Colors.blueGrey
    ];
    _bgColor = bgColors[Random().nextInt(7)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: _bgColor,
          // backgroundColor: Theme.of(context).primaryColor,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                '${f.format(widget.transaction.amount / 1000)}k',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.timestamp),
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width >= 360
            ? TextButton.icon(
                onPressed: () =>
                    widget.onDeleteTransaction(widget.transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  "Delete",
                  style: TextStyle(color: Theme.of(context).errorColor),
                ))
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  widget.onDeleteTransaction(widget.transaction.id);
                },
              ),
      ),
    );
  }
}
