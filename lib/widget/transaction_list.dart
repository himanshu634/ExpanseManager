import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import '../model/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  const TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 450,
      // reverse: true,
      child: _transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No Transaction added yet ! ',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(
                    transaction: _transactions[index],
                    deleteTransaction: _deleteTransaction);
              },
            ),
    );
  }
}

