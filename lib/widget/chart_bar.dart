import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final label;
  final double amount;
  final double spendinAmountPct;

  const ChartBar({this.amount, this.label, this.spendinAmountPct});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '\$$amount',
                  style: TextStyle(fontFamily: 'Courgette'),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              // padding: EdgeInsets.all(2),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendinAmountPct,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '$label',
                  style: const TextStyle(
                    fontFamily: 'Courgette',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
