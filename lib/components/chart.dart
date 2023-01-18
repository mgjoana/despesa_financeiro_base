// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  // função que mostre no construtor chart qual transação caiu no dia da semana
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  //função que vai retornar uma lista com elementos de string e objeto
  List<Map<String, dynamic>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;
      //comparativo se o dia da semana é o mesmo das transações recentes
      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;
        //se for verdadeiro a condição, vai somatizar o valor da transação atual, gerando a soma total
        if (sameDay && sameMonth & sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      //formatação da data pela letra da semana
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.1, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  //propriedade para definir os dias da semana do gráfico
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                percentage: _weekTotalValue == 0
                    ? 0
                    : (tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
