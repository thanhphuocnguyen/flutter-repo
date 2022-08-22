import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/widgets/component_widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function onDeleteTransaction;

  // late String inpTitle;
  // late String inpAmount;

  const TransactionList(
      {Key? key, required this.transactions, required this.onDeleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: ((context, constraints) => Column(
                    children: [
                      Text(
                        'There are no transaction yet!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: constraints.maxHeight * 0.7,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )),
            )
          : ListView(
              children: transactions
                  .map((e) => TransactionItem(
                      // key: UniqueKey(),
                      key: ValueKey(e.id),
                      transaction: e,
                      onDeleteTransaction: onDeleteTransaction))
                  .toList()),
    );
  }
}
