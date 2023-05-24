import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'transaction.dart';
import 'transaction_details_screen.dart';

class TransactionListScreen extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  late Future<List<Transaction>> _transactions;
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _transactions = fetchTransactions();
  }

  Future<List<Transaction>> fetchTransactions() async {
    final response = await http.get(Uri.parse(
        'https://64677d7f2ea3cae8dc3091e7.mockapi.io/api/v1/transactions'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<Transaction> transactions = jsonList
          .map((jsonObject) => Transaction.fromJson(jsonObject))
          .toList();
      transactions.sort((a, b) => a.date.compareTo(b.date));
      return transactions;
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  Widget _buildList(BuildContext context, List<Transaction> transactions) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(
            transaction.getFormattedDate(),
          ),
          subtitle: Text(
              '${transaction.amount.toStringAsFixed(2)} ${transaction.currency} • ${transaction.type}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionDetailsScreen(transaction),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGrid(BuildContext context, List<Transaction> transactions) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionDetailsScreen(transaction),
              ),
            );
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  transaction.getFormattedDate(),
                ),
                SizedBox(height: 8),
                Text(
                    '${transaction.amount.toStringAsFixed(2)} ${transaction.currency} • ${transaction.type}'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _transactions,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _isGridView
                ? _buildGrid(context, snapshot.data!)
                : _buildList(context, snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isGridView ? Icons.list : Icons.grid_on),
              onPressed: _toggleView,
            ),
          ],
        ),
      ),
    );
  }
}
