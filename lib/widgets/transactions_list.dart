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
  final Function _deleteTransaction;
  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: <Widget>[
                Text(
                  "No transactions added yet",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.1,
                ),
                Container(
                  height: constraint.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/hacker.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
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
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () =>
                        _deleteTransaction(_transactions[index].id),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
            itemCount: _transactions.length,
          );
  }
}
