import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final double amount;
  final DateTime timestamp;
  final String title;
  Transaction({
    Key? key,
    required this.id,
    required this.amount,
    required this.timestamp,
    required this.title,
  });
}
