import 'package:flutter/material.dart';
import 'package:sa_estoque_somativa/controllers/movimentacao_controller.dart';
import 'package:sa_estoque_somativa/models/movimentacao_model.dart';
import 'package:sa_estoque_somativa/models/produto_model.dart';

class AddMovimentacaoScreen extends StatefulWidget {
  final Produto produto;
  const AddMovimentacaoScreen({super.key, required this.produto});

  @override
  State<AddMovimentacaoScreen> createState() => _AddMovimentacaoScreenState();
}

class _AddMovimentacaoScreenState extends State<AddMovimentacaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantidadeController = TextEditingController();
  final _observacaoController = TextEditingController();
  final _movimentacaoController = MovimentacaoController();
  String _tipoMovimentacao = 'Entrada';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveMovimentacao() async {
    if (_formKey.currentState!.validate()) {
      final quantidade = int.parse(_quantidadeController.text.trim());
      final DateTime dataFinal = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final movimentacao = Movimentacao(
        produtoId: widget.produto.id!,
        tipoMovimentacao: _tipoMovimentacao,
        quantidade: quantidade,
        dataHora: dataFinal.toIso8601String(),
        observacao: _observacaoController.text.trim().isEmpty
            ? 'Sem observa��es'
            : _observacaoController.text.trim(),
      );

      try {
        await _movimentacaoController.salvaMovimentacao(movimentacao, widget.produto);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Movimenta��o registrada com sucesso!')),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Movimenta��o')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _tipoMovimentacao,
                decoration: InputDecoration(
                  labelText: 'Tipo de Movimenta��o',
                  border: OutlineInputBorder(),
                ),
                items: ['Entrada', 'Sa�da']
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _tipoMovimentacao = value;
                    });
                  }
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _quantidadeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantidade',
                  prefixIcon: Icon(Icons.confirmation_num),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a quantidade';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Quantidade inv�lida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Data: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: Text('${_selectedTime.format(context)}'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _observacaoController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Observa��o',
                  prefixIcon: Icon(Icons.note),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveMovimentacao,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Registrar Movimenta��o'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    _observacaoController.dispose();
    super.dispose();
  }
}

