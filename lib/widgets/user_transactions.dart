import 'package:Expenses_Manager/models/transaction.dart';
import 'package:Expenses_Manager/widgets/new_transaction.dart';
import 'package:Expenses_Manager/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

// stateful widget which gets updated whenever new transaction is added

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  //  List of transactions with some dummy transactions
  final List<Transaction> _transactions = [
    Transaction(
      id: "t1",
      title: "Item 1",
      price: 10,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Item 2",
      price: 20,
      date: DateTime.now(),
    ),
  ];

  //  Adds a new transaction to the list whenever Add Transaction is pressed or enter is pressed in keyboard
  void _addNewTransaction(String txTitle, double txAmount) {
    // Currently using current DateTime as transaction id
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        price: txAmount,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}
