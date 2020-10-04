import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double totalAmountSpent;

  ChartBar(this.label, this.amountSpent, this.totalAmountSpent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text("Rs.${this.amountSpent.toStringAsFixed(0)}",
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark, fontSize: 5)),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 80,
          width: 15,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                  heightFactor: totalAmountSpent != 0
                      ? amountSpent / totalAmountSpent
                      : 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: 5,
          ),
        ),
      ],
    );
  }
}
