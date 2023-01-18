// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Atributos para o gráfico
class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;


//Foi definido os parametros do grafico (column e quantas casas decimais vai ser no valor),
  ChartBar(
      {required this.label, required this.value, required this.percentage});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(child: Text('${value.toStringAsFixed(2)}')),
        ),
         //No container foi definido os parametros da barra do grafico ,
         //e no container mais abaixo foi definido a cor da barra
        SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
