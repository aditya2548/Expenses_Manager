import 'package:Expenses_Manager/models/transaction.dart';
import 'package:Expenses_Manager/widgets/chart.dart';
import 'package:Expenses_Manager/widgets/new_transaction.dart';
import 'package:Expenses_Manager/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expenses Manager",
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.dark().textTheme.copyWith(
                headline1: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.dark().textTheme.copyWith(
                  headline1: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  List of transactions with some dummy transactions
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: "t1",
    //   title: "Item 1",
    //   price: 10,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Item 2",
    //   price: 20,
    //   date: DateTime.now(),
    // ),
  ];

  //  Getter to fetch this week's transactions
  List<Transaction> get _weeklyTransactions {
    return _transactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              Duration(
                days: 7,
              ),
            ),
          ),
        )
        .toList();
  }

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

  //  function to display NewTransaction widget in a bottom sheet
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses Manager"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //  Display chart of this week's transactions
            Chart(_weeklyTransactions),
            // stateful widget which gets updated whenever new transaction is added
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
