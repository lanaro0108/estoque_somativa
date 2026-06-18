import 'package:sa_estoque_somativa/database/database_helper.dart';
import 'package:sa_estoque_somativa/models/movimentacao_model.dart';
import 'package:sa_estoque_somativa/models/produto_model.dart';

class MovimentacaoController {
  final _dbHelper = DatabaseHelper();

  Future<bool> salvaMovimentacao(
      Movimentacao movimentacao, Produto produto) async {
    final int novoEstoque = produto.quantidadeEstoque +
        (movimentacao.tipoMovimentacao == 'Entrada'
            ? movimentacao.quantidade
            : -movimentacao.quantidade);

    if (novoEstoque < 0) {
      throw Exception('Quantidade insuficiente em estoque');
    }

    produto.quantidadeEstoque = novoEstoque;
    await _dbHelper.insertMovimentacao(movimentacao);
    await _dbHelper.updateProduto(produto);
    return true;
  }

  Future<List<Movimentacao>> listarMovimentacoes(int produtoId) async =>
      await _dbHelper.getMovimentacoesPorProduto(produtoId);
}

