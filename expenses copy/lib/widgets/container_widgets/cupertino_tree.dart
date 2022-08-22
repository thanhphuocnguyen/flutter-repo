import 'package:flutter/cupertino.dart';
import 'package:personal_expenses/widgets/component_widgets/new_transaction.dart';

class CupertinoTree extends StatelessWidget {
  final Widget home;
  final Function onAddTransaction;

  const CupertinoTree(
      {Key? key, required this.home, required this.onAddTransaction})
      : super(key: key);

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: ((context) => GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(onAddTransaction: onAddTransaction),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Builder(
        builder: (context) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () {
                    _showActionSheet(context);
                  },
                )
              ],
            ),
          ),
          child: home,
        ),
      ),
    );
  }
}
