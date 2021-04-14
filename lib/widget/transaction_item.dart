import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    const _availableColors = [
      Colors.purple,
      Colors.yellow,
      Colors.blue,
      Colors.black,
    ];
    _bgColor = _availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.purple,
      borderOnForeground: true,
      elevation: 5,
      child: Container(
        // borderRadius: BorderRadius.circular(),
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(45)),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Text(
                "\$${widget.transaction.amount}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            radius: 35,
            backgroundColor: _bgColor,
          ),
          title: Text(
            '${widget.transaction.title}',
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            '${DateFormat().add_yMMMd().format(widget.transaction.date)}',
            style: TextStyle(
              fontFamily: 'Courgette',
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => widget.deleteTransaction(widget.transaction.id),
          ),
        ),
      ),
    );
  }
}
