import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

 const Chart(this._recentTransactions);

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;

      for (int i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].date.year == weekDay.year &&
            _recentTransactions[i].date.month == weekDay.month &&
            _recentTransactions[i].date.day == weekDay.day) {
          totalAmount += _recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'totalAmount': totalAmount
      };
    }).reversed.toList();
  }

  double get totalSpendings {
    return _groupedTransactions.fold(0.0, (sum, data) {
      return sum + data['totalAmount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_groupedTransactions);
    return Container(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _groupedTransactions.map((tx) {
              return Flexible(
                fit: FlexFit.loose,
                // flex:3,
                child: ChartBar(
                  amount: tx['totalAmount'],
                  label: tx['day'],
                  spendinAmountPct: totalSpendings == 0
                      ? 0
                      : (tx['totalAmount'] as double) / totalSpendings,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
