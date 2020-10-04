import 'package:Expenses_Manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//  Stateless widget to store the list of transactions
//  ListView.Builder is used as only required transaction are rendered(efficient than ListView)
//  takes list of transactions through constructor, which are passed through the stateful widget
//  UserTransactions (connecting stateless widgets NewTransactions and TransactionsList )
//  An image is displayed if no transaction present
class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transactions added yet",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    "assets/images/hacker.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              "Rs.${_transactions[index].price.toStringAsFixed(2)}"),
                        ),
                      ),
                    ),
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        _transactions[index].title,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(_transactions[index].date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
    );
  }
}
