// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_string_escapes

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  final Function(String, String, double, DateTime) onUpdate;
  TransactionList(this.transactions, this.onRemove, this.onUpdate);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //exibição de imagem + texto de transação caso não possua, executando a column
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Nenhuma Transação Cadastrada...',
                  style: Theme.of(context).textTheme.headline6,
                ),
                //define o espaçamento do texto em relação a borda/imagem
                SizedBox(height: 20),
                Container(
                  height: 200,
                  /*child: Image.asset(
                    'assets/R.jpg',
                    //fit: BoxFit.cover,
                  ),*/
                  child: Image.network(
                   'https://i.pinimg.com/originals/cd/c1/65/cdc165b00635ea37b1f0064a37430683.png',
                  ),
                ),
              ],
            )
          : ListView.builder(
              //quantidade de itens na lista (tamanho)
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(child: Text('R\$${tr.value}')),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                    trailing: SizedBox(
                      width: 250,
                      child: Row(
                        children: [
                          /*IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite)),*/
                          /* IconButton(
                              onPressed: null, icon: const Icon(Icons.edit)),*/
                          IconButton(
                              onPressed: () => onRemove(tr.id),
                              icon: const Icon(Icons.delete),
                              color: Theme.of(context).errorColor),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
