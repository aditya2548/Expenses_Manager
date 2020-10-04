import 'package:Expenses_Manager/models/transaction.dart';
import 'package:Expenses_Manager/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> lastWeekTransactions;
  Chart(this.lastWeekTransactions);

  double get weeklyTotalSum {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum += element["amount"];
    });
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < lastWeekTransactions.length; i++) {
        if (lastWeekTransactions[i].date.day == weekDay.day &&
            lastWeekTransactions[i].date.month == weekDay.month &&
            lastWeekTransactions[i].date.year == weekDay.year) {
          totalSum += lastWeekTransactions[i].price;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 3),
        "amount": totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data["day"],
                data["amount"],
                weeklyTotalSum,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
