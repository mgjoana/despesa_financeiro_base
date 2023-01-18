// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, use_function_type_syntax_for_parameters, unused_element

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, String, double, DateTime) onSubmit;
  final void Function(String, String, double, DateTime) onUpdate;

  // ignore: use_key_in_widget_constructors
  TransactionForm(
    Function(String id, String title, double value, DateTime date)
        this.onSubmit,
    Function(String id, String title, double value, DateTime date)
        this.onUpdate,
  );

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  // formulário que recebe as informações
  // da descricão e seu valor
  _submitForm() {
    final id = Random().nextDouble().toString();
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    // validação das informações
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    //valores dos parâmentros válidos
    widget.onSubmit(id, title, value, _selectedDate!);
  }

  _updateForm() {
    final id = Random().nextDouble().toString();
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    // validação das informações
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    //valores dos parâmentros válidos
    widget.onUpdate(id, title, value, _selectedDate!);
  }

  //função que abrirá modal do calendário, com paramâmetros
  //do ano mais antigo que pode selecionar, a referência da data de hoje
  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      //mudar comportamento da data quando selecionado
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'Nenhuma data selecionada.'
                        : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}'),
                  ),
                  OutlinedButton(
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      _showDatePicker();
                    },
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  child: const Text(
                    'Nova Transação',
                    style: TextStyle(
                      color: Colors.purple,
                      //backgroundColor: Theme.of(context).textTheme.button?.color,
                    ),
                  ),
                  onPressed: _submitForm,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  child: const Text(
                    'Atualizar',
                    style: TextStyle(
                      color: Colors.green,
                      //backgroundColor: Theme.of(context).textTheme.button?.color,
                    ),
                  ),
                  onPressed: null,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
