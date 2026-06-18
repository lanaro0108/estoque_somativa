import 'package:sa_estoque_somativa/database/database_helper.dart';
import 'package:sa_estoque_somativa/models/produto_model.dart';

class ProdutoController {
  final _dbHelper = DatabaseHelper();

  Future<int> salvarProduto(Produto produto) async {
    return _dbHelper.insertProduto(produto);
  }

  Future<List<Produto>> listarTodos() async => _dbHelper.getProdutos();
}
