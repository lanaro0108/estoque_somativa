import 'package:flutter/material.dart';
import 'package:sa_petshop_sqlite/controllers/consulta_controller.dart';
import 'package:sa_petshop_sqlite/models/consulta_model.dart';
import 'package:sa_petshop_sqlite/models/pet_model.dart';
import 'package:sa_petshop_sqlite/screens/pet_detail_screen.dart';

class AddConsultaScreen extends StatefulWidget {
  final Pet pet; //Levar a informação do pet selecionado na tela anterior
  const AddConsultaScreen({super.key, required this.pet});

  @override
  State<AddConsultaScreen> createState() => _AddConsultaScreenState();
}

class _AddConsultaScreenState extends State<AddConsultaScreen> {
  // Formulário de cadastro de serviços
  final _formKey =
      GlobalKey<FormState>(); // Permite as validações do formulário

  final _consultaController =
      ConsultaController(); // Permite a conexão com o BD

  late String _tipoServico;
  late String _observacao;
  DateTime _selectedDate = DateTime.now(); //pego o dia atual
  TimeOfDay _selectedTime = TimeOfDay.now(); //pego a hora atual

  // Método para abrir a seleção de data
  void _dataSelecionada(BuildContext context) async {
    // Permite abrir um calendário na tela, função nativa do Flutter
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate =
            picked; // Modifico a _selectedDate para a data selecionada
      });
    }
  }

  //método para abrir a Seleção de Hora
  void _horaSelecionada(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  //método para salvar a consulta/serviço

  void _salvarConsulta() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Salva os Valores do Formulário

      // Correção de Data para banco de dados, para o formato ISO8601
      final DateTime dataFinal = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final newConsulta = Consulta(
        petId: widget.pet.id!,
        tipoServico: _tipoServico,
        dataHora: dataFinal.toIso8601String(),
        // Ternario para o campo de observação
        observacoes: _observacao.isEmpty ? "Sem Observações" : _observacao,
      );

      try {
        await _consultaController.salvaConsulta(newConsulta);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Agendamento Feito com Sucesso")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetDetailScreen(pet: widget.pet),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Exception: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}