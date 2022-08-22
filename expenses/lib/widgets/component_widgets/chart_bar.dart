import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String date;
  final double spendingAmount;
  final double spendingPercentOfTotal;
  const ChartBar({
    Key? key,
    required this.date,
    required this.spendingAmount,
    required this.spendingPercentOfTotal,
  }) : super(key: key);

  String _convertSpending() {
    if (spendingAmount / 1000000 >= 1) {
      return '${(spendingAmount / 1000000).toStringAsFixed(1)}tr';
    } else if (spendingAmount / 1000 >= 1) {
      return '${(spendingAmount / 1000).toStringAsFixed(1)}k';
    }
    return '${spendingAmount}k';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Column(
        children: <Widget>[
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: Text(
              date,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 15,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[700]!, width: 1.0),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentOfTotal,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(ctx).primaryColor,
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: Text(
              _convertSpending(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
