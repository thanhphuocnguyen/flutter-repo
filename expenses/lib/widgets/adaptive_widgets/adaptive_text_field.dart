import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSubmit;
  final String? labelText;
  final TextInputType? keyboardType;
  const AdaptiveTextField({
    Key? key,
    required this.controller,
    this.onSubmit,
    this.labelText,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: CupertinoTextField(
              controller: controller,
              onSubmitted: (_) => {
                if (onSubmit != null) {onSubmit!()}
              },
              textInputAction: TextInputAction.newline,
              placeholder: labelText,
              keyboardType: keyboardType,
            ),
          )
        : TextField(
            controller: controller,
            decoration: InputDecoration(labelText: labelText),
            onSubmitted: (_) => {
              if (onSubmit != null) {onSubmit!()}
            },
            keyboardType: keyboardType,
          );
  }
}
