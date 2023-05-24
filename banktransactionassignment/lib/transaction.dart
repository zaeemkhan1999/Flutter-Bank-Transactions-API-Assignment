import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final DateTime date;
  final double amount;
  final String currency;
  final String type;
  final String description;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.currency,
    required this.type,
    required this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: DateTime.parse(json['date']),
      amount: double.parse(json['amount']),
      currency: json['currency'],
      type: json['type'],
      description: json['description'],
    );
  }

  String getFormattedDate() {
    return DateFormat('dd-MMM-yyyy').format(date);
  }
}
