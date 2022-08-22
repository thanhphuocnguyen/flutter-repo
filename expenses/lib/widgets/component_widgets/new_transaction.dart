import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/adaptive_widgets/adaptive_button.dart';
import 'package:personal_expenses/widgets/adaptive_widgets/adaptive_text_field.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTransaction;

  const NewTransaction({Key? key, required this.onAddTransaction})
      : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleControl = TextEditingController();
  final amountControl = TextEditingController();
  DateTime? _pickedDate;

  // final dateControl;

  void _onSubmit() {
    final enteredTitle = titleControl.text;
    final enteredAmount = double.parse(amountControl.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty) {
      return;
    }

    widget.onAddTransaction(
      double.parse(amountControl.text),
      titleControl.text,
      _pickedDate,
    );
    Navigator.of(context).pop();
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: ((context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                onDateTimeChanged: (DateTime newDate) {
                  setState(
                    () {
                      _pickedDate = newDate;
                    },
                  );
                },
                initialDateTime: _pickedDate,
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
              ),
            ),
          )),
    );
  }

  void _openDatePicker(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: _pickedDate ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    return SingleChildScrollView(
      child: Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Create new spends',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  AdaptiveTextField(
                    // onChanged: (value) {
                    //   inpTitle = value;
                    // },
                    labelText: "Title",
                    controller: titleControl,
                    onSubmit: _onSubmit,
                  ),
                  AdaptiveTextField(
                    // onChanged: (value) => inpAmount = value,
                    controller: amountControl,
                    keyboardType: TextInputType.number,
                    labelText: "Amount",
                    onSubmit: _onSubmit,
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _pickedDate == null
                                ? "No day choosen"
                                : 'Picked date: ${DateFormat.yMMMMd().format(_pickedDate!)}',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Platform.isIOS
                                ? _showCupertinoDatePicker(context)
                                : _openDatePicker(context);
                          },
                          icon: const Icon(Icons.edit_calendar),
                          style: TextButton.styleFrom(
                              textStyle:
                                  Theme.of(context).textTheme.titleSmall),
                          label: const Text("Choose day"),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: AdaptiveButton(onSubmit: _onSubmit, isIOS: isIOS),
                  )
                ]),
          )),
    );
  }
}
// style: TextButton.styleFrom(
//                                 textStyle:
//                                     Theme.of(context).textTheme.titleSmall),
//                             onPressed: () {
//                               _openDatePicker(context);
//                             },
//                             child: const Text("Choose day")