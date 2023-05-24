import 'package:flutter/material.dart';
import 'transaction_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Transactions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransactionListScreen(),
    );
  }
}
