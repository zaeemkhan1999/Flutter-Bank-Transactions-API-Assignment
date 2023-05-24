import 'package:flutter/material.dart';
import 'transaction.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction transaction;

  TransactionDetailsScreen(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${transaction.getFormattedDate()}'),
            Text(
                'Amount: ${transaction.amount.toStringAsFixed(2)} ${transaction.currency}'),
            Text('Type: ${transaction.type}'),
            Text('Description: ${transaction.description}'),
          ],
        ),
      ),
    );
  }
}
