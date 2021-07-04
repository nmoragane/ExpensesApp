import 'package:expenses/models/transaction.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactons;

  const Chart(this.recentTransactons);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactons.length; i++) {
        if (recentTransactons[i].date.day == weekDay.day &&
            recentTransactons[i].date.month == weekDay.month &&
            recentTransactons[i].date.year == weekDay.year) {
          totalSum += recentTransactons[i].amount;
        }
      }

      return {
        'day': DateFormat.E(weekDay),
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
