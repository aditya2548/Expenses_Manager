import 'package:Expenses_Manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//  Stateless widget to store the list of transactions
//  ListView.Builder is used as only required transaction are rendered(efficient than ListView)
//  takes list of transactions through constructor, which are passed through the stateful widget
//  UserTransactions (connecting stateless widgets NewTransactions and TransactionsList )
class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[200],
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 50,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.purple, width: 1),
                  ),
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "Rs.${_transactions[index].price.toString()}",
                      style: TextStyle(color: Colors.purple[700]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          _transactions[index].title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Text(
                      DateFormat().format(_transactions[index].date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: _transactions.length,
      ),
    );
  }
}
