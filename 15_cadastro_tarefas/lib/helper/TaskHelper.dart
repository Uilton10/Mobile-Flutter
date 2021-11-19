import 'package:teste01/model/Task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskHelper {
  static final String nomeTabela = "Task";

  static final TaskHelper _taskHelper = TaskHelper._internal();

  var _db ;

  factory TaskHelper() {
    return _taskHelper;
  }

  TaskHelper._internal() {}

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
        "descricao VARCHAR)";
    await db.execute(sql);
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados =
    join(caminhoBancoDados, "banco_minhas_tasks.db");

    var db =
    await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarTask(Task tasks) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, tasks.toMap());
    return resultado;
  }

  recuperarTask() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY data DESC ";
    List task = await bancoDados.rawQuery(sql);
    return task;
  }

  Future<int> atualizarTask(Task task) async {
    var bancoDados = await db;
    return await bancoDados.update(nomeTabela, task.toMap(),
        where: "id = ?", whereArgs: [task.id]);
  }

  Future<int> removerTask(int id) async {
    var bancoDados = await db;
    return await bancoDados
        .delete(nomeTabela, where: "id = ?", whereArgs: [id]);
  }
}
