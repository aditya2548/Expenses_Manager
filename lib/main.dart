import 'package:Expenses_Manager/models/transaction.dart';
import 'package:Expenses_Manager/widgets/chart.dart';
import 'package:Expenses_Manager/widgets/new_transaction.dart';
import 'package:Expenses_Manager/widgets/transactions_list.dart';
import 'package:flutter/cupertino.dart';
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
  //  bool for show chart switch
  bool showChart = false;
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
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime pickedDate) {
    // Currently using current DateTime as transaction id
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        price: txAmount,
        date: pickedDate);

    setState(() {
      _transactions.add(newTx);
    });
  }

  //  To delete transaction with given id
  void _deleteTransaction(String id) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Do you want to delete the transaction?",
              style:
                  TextStyle(color: Theme.of(context).errorColor, fontSize: 15)),
          elevation: 10,
          actions: [
            FlatButton(
              onPressed: () {
                setState(() {
                  _transactions.removeWhere((element) => element.id == id);
                });
                Navigator.of(context).pop();
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No")),
          ],
        );
      },
    );
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
    //  Variable to store mediaQuery metadata
    final mediaQuery = MediaQuery.of(context);
    //  Variable to know device orientation
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    //  Appbar stored in variable to get appBar height
    final appBar = AppBar(
      title: Text("Expenses Manager"),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context)),
      ],
    );

    //  TxList Wizard stored in a variable
    final txListWizard = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_transactions, _deleteTransaction));

    //  Chart widget to display chart in landscape(factor = 0.7)
    final chartWidgetBig = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      width: mediaQuery.size.width * 0.9,
      child: Chart(_weeklyTransactions),
    );
    //  Chart widget to display chart in portrait(factor = 0.3)
    final chartWidgetSmall = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.3,
      child: Chart(_weeklyTransactions),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //  Switch(for chart and list) which is visible only in landscape mode
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Display chart",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Switch(
                      value: showChart,
                      onChanged: (val) {
                        setState(() {
                          showChart = val;
                        });
                      })
                ],
              ),
            //  if in portrait mode, display both chart and list
            if (!isLandscape) chartWidgetSmall,
            if (!isLandscape) txListWizard,

            //  if in landscape mode, display one of chart and list depending on switch
            if (isLandscape) showChart == true ? chartWidgetBig : txListWizard,
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
