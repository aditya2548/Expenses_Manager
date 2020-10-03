import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//  Stateless widget to store the details of new transaction
//  takes addTransaction function through constructor, which are passed through the stateful widget
//  UserTransactions (connecting stateless widgets NewTransactions and TransactionsList )
class NewTransaction extends StatefulWidget {
  final Function _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    //  Validating if entered data is correct
    //    ->  non empty title
    //    ->  non empty and positive amount
    //If invalid, display a toast
    if (titleController.text.isEmpty ||
        amountController.text == "" ||
        double.tryParse(amountController.text) == null ||
        double.parse(amountController.text) <= 0) {
      Fluttertoast.showToast(
          msg: "Please enter valid details!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    widget._addTransaction(
        titleController.text, double.parse(amountController.text));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              style: TextStyle(fontSize: 14),
              //  Used to submit data when enter is pressed from keyboard (using dummy returned string "_")
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                  labelText: "Title",
                  contentPadding: EdgeInsets.fromLTRB(5, 2, 2, 5)),
              controller: titleController,
            ),
            TextField(
              style: TextStyle(fontSize: 14),
              //  Used to submit data when enter is pressed from keyboard (using dummy returned string "_")
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Amount",
                  contentPadding: EdgeInsets.fromLTRB(5, 2, 2, 5)),
              controller: amountController,
            ),
            FlatButton(
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.purple),
              ),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
