import 'package:flutter/material.dart';
import 'package:sa_estoque_somativa/controllers/produto_controller.dart';
import 'package:sa_estoque_somativa/models/produto_model.dart';

class AddProdutoScreen extends StatefulWidget {
  const AddProdutoScreen({super.key});

  @override
  State<AddProdutoScreen> createState() => _AddProdutoScreenState();
}

class _AddProdutoScreenState extends State<AddProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoCustoController = TextEditingController();
  final _precoVendaController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _codigoController = TextEditingController();

  final ProdutoController _produtoController = ProdutoController();

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      final novoProduto = Produto(
        nome: _nomeController.text.trim(),
        descricao: _descricaoController.text.trim(),
        precoCusto: double.parse(_precoCustoController.text.trim()),
        precoVenda: double.parse(_precoVendaController.text.trim()),
        quantidadeEstoque: int.parse(_quantidadeController.text.trim()),
        codigo: _codigoController.text.trim(),
      );

      final sucesso = await _produtoController.salvarProduto(novoProduto) > 0;

      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produto cadastrado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar o produto.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Produto")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: "Nome do Produto",
                  prefixIcon: Icon(Icons.label),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Informe o nome do produto"
                    : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: "Descrição",
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Informe a descrição"
                    : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _precoCustoController,
                keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: "Preço de Custo",
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o preço de custo";
                  }
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return "Preço inválido";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _precoVendaController,
                keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: "Preço de Venda",
                  prefixIcon: Icon(Icons.sell),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o preço de venda";
                  }
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return "Preço inválido";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _quantidadeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Quantidade Inicial",
                  prefixIcon: Icon(Icons.inventory_2),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe a quantidade inicial";
                  }
                  if (int.tryParse(value) == null) {
                    return "Quantidade inválida";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _codigoController,
                decoration: InputDecoration(
                  labelText: "Código do Produto",
                  prefixIcon: Icon(Icons.code),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Informe o código do produto"
                    : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text("Salvar Produto"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _precoCustoController.dispose();
    _precoVendaController.dispose();
    _quantidadeController.dispose();
    _codigoController.dispose();
    super.dispose();
  }
}

