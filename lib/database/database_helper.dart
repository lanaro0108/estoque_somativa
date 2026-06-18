import 'package:path/path.dart';
import 'package:sa_estoque_somativa/models/produto_model.dart';
import 'package:sa_estoque_somativa/models/movimentacao_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), "estoque.db");
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async => await db.execute("PRAGMA foreign_keys = ON"),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE produtos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          descricao TEXT,
          precoCusto REAL,
          precoVenda REAL,
          quantidadeEstoque INTEGER,
          codigo TEXT)''');
        await db.execute('''CREATE TABLE movimentacoes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          produtoId INTEGER,
          tipoMovimentacao TEXT,
          quantidade INTEGER,
          dataHora TEXT,
          observacao TEXT,
          FOREIGN KEY(produtoId) REFERENCES produtos(id) ON DELETE CASCADE)''');
      },
    );
  }

  Future<int> insertProduto(Produto produto) async =>
      (await database).insert("produtos", produto.toMap());

  Future<List<Produto>> getProdutos() async {
    final List<Map<String, dynamic>> maps = await (await database).query(
      "produtos",
      orderBy: "nome ASC",
    );
    return List.generate(maps.length, (e) => Produto.fromMap(maps[e]));
  }

  Future<int> updateProduto(Produto produto) async =>
      (await database).update(
        "produtos",
        produto.toMap(),
        where: "id = ?",
        whereArgs: [produto.id],
      );

  Future<int> insertMovimentacao(Movimentacao movimentacao) async =>
      (await database).insert("movimentacoes", movimentacao.toMap());

  Future<List<Movimentacao>> getMovimentacoesPorProduto(int produtoId) async {
    final List<Map<String, dynamic>> maps = await (await database).query(
      "movimentacoes",
      where: "produtoId = ?",
      whereArgs: [produtoId],
      orderBy: "dataHora DESC",
    );
    return List.generate(
      maps.length,
      (e) => Movimentacao.fromMap(maps[e]),
    );
  }
}

