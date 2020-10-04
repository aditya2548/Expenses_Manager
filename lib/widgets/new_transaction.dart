import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  //  To store selected date
  DateTime _selectedDate;
  //  focusnode to switch to amount textfield when enter pressed on title field
  final _amountFocus = FocusNode();

  void _submitData() {
    //  Validating if entered data is correct
    //    ->  non empty title
    //    ->  non empty and positive amount
    //    ->  date is non null
    //If invalid, display a toast
    if (_titleController.text.isEmpty ||
        _amountController.text == "" ||
        double.tryParse(_amountController.text) == null ||
        double.parse(_amountController.text) <= 0 ||
        _selectedDate == null) {
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

    widget._addTransaction(_titleController.text,
        double.parse(_amountController.text), _selectedDate);

    Navigator.of(context).pop();
  }

  //  Utility function to display date-picker
  void _dispDatePicker() {
    showDatePicker(
            fieldHintText: "Select a date",
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 5,
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                style: Theme.of(context).textTheme.headline1,
                //  Used to go to next entry(amount) when enter is pressed from keyboard (using dummy returned string "_")
                textInputAction: TextInputAction.next,
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_amountFocus),
                decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(
                      fontSize: 10,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(5, 2, 2, 5)),
                controller: _titleController,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                style: Theme.of(context).textTheme.headline1,
                //  Used to submit data when enter is pressed from keyboard (using dummy returned string "_")
                focusNode: _amountFocus,
                onSubmitted: (_) => _dispDatePicker(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: TextStyle(
                      fontSize: 10,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(5, 2, 2, 5)),
                controller: _amountController,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No date chosen"
                          : DateFormat.yMMMd().format(_selectedDate),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    FlatButton(
                      onPressed: _dispDatePicker,
                      child: Text(
                        "Choose a date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text(
                  "Add Transaction",
                ),
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
                color: Theme.of(context).primaryColorDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
