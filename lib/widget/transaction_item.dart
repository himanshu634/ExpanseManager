import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionItem({
    @required this.transaction,
    @required this.deleteTransaction,
  });

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
                "\$${transaction.amount}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            radius: 35,
            backgroundColor: Colors.purple,
          ),
          title: Text(
            '${transaction.title}',
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            '${DateFormat().add_yMMMd().format(transaction.date)}',
            style: TextStyle(
              fontFamily: 'Courgette',
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => deleteTransaction(transaction.id),
          ),
        ),
      ),
    );
  }
}
