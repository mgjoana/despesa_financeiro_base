// ignore: unused_import
// ignore_for_file: constant_identifier_names, unused_import

import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });
}
