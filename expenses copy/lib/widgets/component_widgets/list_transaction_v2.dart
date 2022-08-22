import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';

class TransactionListV2 extends StatelessWidget {
  final List<Transaction> transactions;
  final Function onDeleteTransaction;
  final curr = Intl.defaultLocale = 'vi';

  // late String inpTitle;
  // late String inpAmount;
  final f = NumberFormat("###,###", "en_US");

  TransactionListV2(
      {Key? key, required this.transactions, required this.onDeleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'There are no transaction yet!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                      elevation: 4,
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            // backgroundColor: Theme.of(context).primaryColor,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  '${f.format(transactions[index].amount / 1000)}k',
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
                            transactions[index].title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            DateFormat.yMMMd(curr)
                                .format(transactions[index].timestamp),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            onPressed: () {
                              onDeleteTransaction(transactions[index].id);
                            },
                          )));
                },
                itemCount: transactions.length,
              ));
  }
}
