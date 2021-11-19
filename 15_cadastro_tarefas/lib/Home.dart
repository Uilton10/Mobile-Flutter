import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'helper/TaskHelper.dart';
import 'model/Task.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _tituloController = TextEditingController();
  var _db = TaskHelper();
  List<Task> _task = [];

  _exibirTelaCadastro({required Task task}) {
    String textoSalvarAtualizar = "";
    if (task.id > 0 ) {
      //atualizar
      _tituloController.text = task.descricao;
      textoSalvarAtualizar = "Atualizar";
    } else {
      //salvando
      _tituloController.text = "";
      textoSalvarAtualizar = "Salvar";
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("$textoSalvarAtualizar Tarefa"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _tituloController,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Tarefa", hintText: "Digite tarefa..."),
                ),

              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar")),
              FlatButton(
                  onPressed: () {
                    //salvar
                    _salvarAtualizarTask(taskSelecionada: task);

                    Navigator.pop(context);
                  },
                  child: Text(textoSalvarAtualizar))
            ],
          );
        });
  }

  _recuperarTask() async {
    List taskRecuperadas = await _db.recuperarTask();

    List<Task> listaTemporaria =  <Task>[];
    for (var item in taskRecuperadas) {
      Task task = Task.fromMap(item);
      listaTemporaria.add(task);
    }

    setState(() {
      _task = listaTemporaria;
    });
    List   Temporaria ;

    //print("Lista de Tarefas: " + tarefasRecuperadas.toString() );
  }

  _salvarAtualizarTask({required Task taskSelecionada}) async {
    String descricao = _tituloController.text;

    if (taskSelecionada.id > 0) {
      //atualizar
      taskSelecionada.descricao = descricao;
      int resultado = await _db.atualizarTask(taskSelecionada);

    } else {

      //salvar
      Task task =  Task(descricao);
      int resultado = await _db.salvarTask(task);
    }

    _tituloController.clear();

    _recuperarTask();
  }

  _formatarData(String data) {
    initializeDateFormatting("pt_BR");

    //Year -> y month-> M Day -> d
    // Hour -> H minute -> m second -> s
    //var formatador = DateFormat("d/MMMM/y H:m:s");
    var formatador = DateFormat.yMd("pt_BR");

    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);

    return dataFormatada;
  }

  _removerTask(int id) async {
    await _db.removerTask(id);

    _recuperarTask();
  }

  @override
  void initState() {
    super.initState();
    _recuperarTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Lista de Tarefas"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _task.length,
                  itemBuilder: (context, index) {
                    final task = _task[index];

                    return Card(
                      child: ListTile(
                        title: Text(task.descricao),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _exibirTelaCadastro(task: task);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _removerTask(task.id);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            Task task  = new Task("");
            _exibirTelaCadastro(task: task);
          }),
    );
  }
}
