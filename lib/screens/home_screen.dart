import 'package:flutter/material.dart';
import 'package:sa_estoque_somativa/controllers/produto_controller.dart';
import 'package:sa_estoque_somativa/models/produto_model.dart';
import 'package:sa_estoque_somativa/screens/add_produto_screen.dart';
import 'package:sa_estoque_somativa/screens/produto_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProdutoController _controller = ProdutoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Controle de Estoque - Produtos")),
      body: FutureBuilder<List<Produto>>(
        future: _controller.listarTodos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final produtos = snapshot.data!;
          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, i) => ListTile(
              leading: Icon(Icons.inventory_2),
              title: Text(produtos[i].nome),
              subtitle: Text(
                  "Código: ${produtos[i].codigo} · Estoque: ${produtos[i].quantidadeEstoque}"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => ProdutoDetailScreen(produto: produtos[i]),
                ),
              ).then((value) => setState(() {})),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => AddProdutoScreen()),
        ).then((value) => setState(() {})),
      ),
    );
  }
}

