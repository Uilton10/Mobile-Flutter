import 'package:teste01/model/Compra.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CompraHelper {
  static final String nomeTabela = "Compra";

  static final CompraHelper _taskHelper = CompraHelper._internal();
  var _db ;

  factory CompraHelper() {
    return _taskHelper;
  }

  CompraHelper._internal() {}

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql = "CREATE TABLE $nomeTabela ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "mercadoria VARCHAR, "
        "quantidade integer)";
    await db.execute(sql);
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados =
    join(caminhoBancoDados, "banco_minhas_compras.db");

    var db =
    await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarCompra(Compra compras) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, compras.toMap());
    return resultado;
  }

  recuperarCompra() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY data DESC ";
    List compras = await bancoDados.rawQuery(sql);
    return compras;
  }

  Future<int> atualizarCompra(Compra compra) async {
    var bancoDados = await db;
    return await bancoDados.update(nomeTabela, compra.toMap(),
        where: "id = ?", whereArgs: [compra.id]);
  }

  Future<int> removerCompra(int id) async {
    var bancoDados = await db;
    return await bancoDados
        .delete(nomeTabela, where: "id = ?", whereArgs: [id]);
  }
}
