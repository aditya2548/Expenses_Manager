import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//  Stateful widget to store the details of new transaction in a bottom sheet
//  takes addTransaction function through constructor which is triggered by
//  floatingActionButton or actionBar button
class NewTransaction extends StatefulWidget {
  final Function _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //  TextEditingController to handle and store text input
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  //  focusnode to switch to amount textfield when enter pressed on title field
  final amountFocus = FocusNode();

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
          backgroundColor: Theme.of(context).errorColor,
          textColor: Theme.of(context).primaryColor,
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
              style: Theme.of(context).textTheme.headline1,
              //  Used to go to next entry(amount) when enter is pressed from keyboard (using dummy returned string "_")
              textInputAction: TextInputAction.next,
              onSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(amountFocus),
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(
                    fontSize: 10,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(5, 2, 2, 5)),
              controller: titleController,
            ),
            TextField(
              style: Theme.of(context).textTheme.headline1,
              //  Used to submit data when enter is pressed from keyboard (using dummy returned string "_")
              focusNode: amountFocus,
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle: TextStyle(
                    fontSize: 10,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(5, 2, 2, 5)),
              controller: amountController,
            ),
            FlatButton(
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
