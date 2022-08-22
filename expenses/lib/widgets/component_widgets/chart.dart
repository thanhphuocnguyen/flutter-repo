import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/widgets/component_widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  const Chart({Key? key, required this.recentTransaction}) : super(key: key);
  List<Map<String, Object>> get groupedTransactionByWeekDay {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;

      for (var trans in recentTransaction) {
        if (trans.timestamp.day == weekDay.day &&
            trans.timestamp.month == weekDay.month &&
            trans.timestamp.year == weekDay.year) {
          totalAmount += trans.amount;
        }
      }

      return {"day": DateFormat.E().format(weekDay), "amount": totalAmount};
    }).reversed.toList();
  }

  double get sumSpending {
    return groupedTransactionByWeekDay.fold(
      0.0,
      (previousValue, element) => previousValue + (element['amount'] as double),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ...groupedTransactionByWeekDay
                .map((e) => Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                        spendingAmount: e['amount'] as double,
                        spendingPercentOfTotal: sumSpending == 0.0
                            ? 0.0
                            : (e['amount'] as double) / sumSpending,
                        date: e['day'] as String,
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
