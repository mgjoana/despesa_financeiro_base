// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_label, annotate_overrides, dead_code, unused_field

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'components/chart.dart';
import '../models/transaction.dart';

main() => runApp(DespesaFApp());

class DespesaFApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber, 
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                //fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              button: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            //fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  //método que adiciona mais transações
  _addTransaction(String id, String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    //operação de adicionar mais transações mudando seu comportamento
    setState(() {
      _transactions.add(newTransaction);
    });

    //navegação onde a modal será fechada pelo pop (pilha)
    Navigator.of(context).pop();
  }

  //método de exclusão pelo id da transação
  //condicionado, se o id que está selecionad é igual ao id salvo em memória,
  //será excluído
  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  // abrir TransactionFormModal
  _opentransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransaction, _updateTransactions);
        });
  }

  _updateTransactions(String id, String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    //operação de adicionar mais transações mudando seu comportamento
    setState(() {
      _transactions;
    });

    //navegação onde a modal será aberta
    Navigator.pushNamed(context, '/transaction_form',
        arguments: _updateTransactions(id, title, value, date));
    //Navigator.of(context).pushNamed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle +'),
        /*actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _opentransactionFormModal(context),
          ),
        ],*/
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //gráfico
            Chart(_recentTransactions),
            TransactionList(
                _transactions, _removeTransaction, _updateTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _opentransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    /*floatingActionButton:
    FloatingActionButton(
      onPressed: (() => Navigator.of(context).pushNamed('/transaction')),
      child: Icon(Icons.add),
    );*/
  }
}
