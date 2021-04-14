import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction) {
    print("This is constructor of NewTransaction");
  }

  @override
  _NewTransactionState createState() {
    print("This is constructor of NewTransaction createState.");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print("This is constructor of NewTransactionState");
  }

  @override
  void initState() {
    print("This is initState of NewTransaction Widget");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print("This is didUpdateWidget of NewTrasaction Widget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("This is dispose of NewTransaction Widget");
    super.dispose();
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    final enteredDate = _selectedDate;

    if (enteredAmount.toString().isEmpty ||
        enteredTitle.isEmpty ||
        enteredDate == null) {
      return;
    }
    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      enteredDate,
    );

    Navigator.of(context).maybePop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : DateFormat.yMMMd().format(_selectedDate),
                    ),
                    TextButton(
                      child: Text(
                        'Select Date',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                ),
                onPressed: () {
                  _submitData();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
