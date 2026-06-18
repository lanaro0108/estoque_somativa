import 'package:flutter/material.dart';
import 'package:sa_estoque_somativa/database/database_helper.dart';
import 'package:sa_estoque_somativa/models/movimentacao_model.dart';
import 'package:sa_estoque_somativa/models/produto_model.dart';
import 'package:sa_estoque_somativa/screens/add_movimentacao_screen.dart';
import 'package:intl/intl.dart';

class ProdutoDetailScreen extends StatefulWidget {
  final Produto produto;
  const ProdutoDetailScreen({super.key, required this.produto});

  @override
  State<ProdutoDetailScreen> createState() => _ProdutoDetailScreenState();
}

class _ProdutoDetailScreenState extends State<ProdutoDetailScreen> {
  final DateFormat _formatador = DateFormat('dd/MM/yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Produto: ${widget.produto.nome}")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.produto.descricao, style: TextStyle(fontSize: 16)),
                SizedBox(height: 12),
                Text("Código: ${widget.produto.codigo}"),
                SizedBox(height: 8),
                Text("Estoque atual: ${widget.produto.quantidadeEstoque}"),
                SizedBox(height: 8),
                Text(
                  "Preço de custo: R\$ ${widget.produto.precoCusto.toStringAsFixed(2)}",
                ),
                SizedBox(height: 4),
                Text(
                  "Preço de venda: R\$ ${widget.produto.precoVenda.toStringAsFixed(2)}",
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Histórico de Movimentações",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Movimentacao>>(
              future: DatabaseHelper().getMovimentacoesPorProduto(
                widget.produto.id!,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                final movimentacoes = snapshot.data!;
                if (movimentacoes.isEmpty) {
                  return Center(
                    child: Text('Nenhuma movimentação registrada.'),
                  );
                }
                return ListView.builder(
                  itemCount: movimentacoes.length,
                  itemBuilder: (context, i) {
                    final mov = movimentacoes[i];
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          mov.tipoMovimentacao == 'Entrada'
                              ? Icons.arrow_circle_up
                              : Icons.arrow_circle_down,
                          color: mov.tipoMovimentacao == 'Entrada'
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text(
                          '${mov.tipoMovimentacao} - ${mov.quantidade} unidades',
                        ),
                        subtitle: Text(
                          '${_formatador.format(DateTime.parse(mov.dataHora))}\n${mov.observacao}',
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Registrar Movimento"),
        icon: Icon(Icons.sync_alt),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => AddMovimentacao(produto: widget.produto),
          ),
        ).then((value) => setState(() {})),
      ),
    );
  }
}
