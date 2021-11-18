import 'package:flutter/material.dart';
import 'package:app_api3/Tarefa.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  List<Tarefa> _tarefas = List<Tarefa>();

  _exibirTelaCadastro({Tarefa tarefa}) {
    String textoSalvarAtualizar = "";
    if (tarefa == null) {
      //salvando
      _tituloController.text = "";
      _descricaoController.text = "";
      textoSalvarAtualizar = "Salvar";
    } else {
      //atualizar
      _tituloController.text = tarefa.title;
      _descricaoController.text = tarefa.description;
      textoSalvarAtualizar = "Atualizar";
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("$textoSalvarAtualizar tarefa"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _tituloController,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Título", hintText: "Digite título..."),
                ),
                TextField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                      labelText: "Descrição", hintText: "Digite descrição..."),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar")),
              FlatButton(
                  onPressed: () {
                    //salvar
                    _salvarAtualizarTarefa(tarefaSelecionada: tarefa);

                    Navigator.pop(context);
                  },
                  child: Text(textoSalvarAtualizar))
            ],
          );
        });
  }

  _recuperarTarefas() async {
    http.Response response =
    await http.get(Uri.parse('https://tarefa-backend.herokuapp.com/tasks'));

    var dadosJson = json.decode(response.body);

    List<Tarefa> tarefas = List();

    for (var tarefa in dadosJson) {
      print("tarefa: " + tarefa["title"]);
      Tarefa t = Tarefa(tarefa["id"], tarefa["title"], tarefa["description"]);
      tarefas.add(t);
    }
    setState(() {
      _tarefas = tarefas;
    });
  }

  _salvarAtualizarTarefa({Tarefa tarefaSelecionada}) async {
    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;

    if (tarefaSelecionada == null) {
      Tarefa tarefa = Tarefa(null, titulo, descricao);
      await _inserirTarefa(tarefa);
    } else {
      tarefaSelecionada.title = titulo;
      tarefaSelecionada.description = descricao;
      await _atualizarTarefa(tarefaSelecionada);
    }

    _tituloController.clear();
    _descricaoController.clear();

    await _recuperarTarefas();
  }

  _inserirTarefa(Tarefa tarefa) async {
    http.Response response = await http.post(
        Uri.parse('https://tarefa-backend.herokuapp.com/tasks'),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: json.encode(tarefa.toMap()));
    return response.statusCode;
  }

  _atualizarTarefa(Tarefa tarefa) async {
    String url = 'https://tarefa-backend.herokuapp.com/tasks/${tarefa.id}';

    var corpo = json.encode(tarefa.toMap());

    http.Response response = await http.put(Uri.parse(url),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);
  }

  _removerTarefa(int id) async {
    String url = 'https://tarefa-backend.herokuapp.com/tasks/${id}';

    http.Response response = await http.delete(Uri.parse(url));

    await _recuperarTarefas();
  }

  @override
  void initState() {
    super.initState();
    _recuperarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas tarefas"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _tarefas.length,
                  itemBuilder: (context, index) {
                    final tarefa = _tarefas[index];

                    return Card(
                      child: ListTile(
                        title: Text(tarefa.title),
                        subtitle: Text(tarefa.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _exibirTelaCadastro(tarefa: tarefa);
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
                                _removerTarefa(tarefa.id);
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
            _exibirTelaCadastro();
          }),
    );
  }
}
