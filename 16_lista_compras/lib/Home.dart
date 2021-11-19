import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'helper/CompraHelper.dart';
import 'model/Compra.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _quantidadeController = TextEditingController();
  var _db = CompraHelper();
  List<Compra> _compras = [];

  _exibirTelaCadastro({required Compra compra}) {
    String textoSalvarAtualizar = "";
    if (compra.id > 0 ) {
      //atualizar
      _tituloController.text = compra.mercadoria;
      _quantidadeController.text = compra.quantidade.toString();
      textoSalvarAtualizar = "Atualizar";
    } else {
      //salvando
      _tituloController.text = "";
      _quantidadeController.text = "";
      textoSalvarAtualizar = "Salvar";
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("$textoSalvarAtualizar Compra"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _tituloController,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Mercadoria", hintText: "Digite mercadoria..."),
                ),
                TextField(
                  controller: _quantidadeController,
                  decoration: InputDecoration(
                      labelText: "Quantidade", hintText: "Digite a quantidade..."),
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
                    _salvarAtualizarCompra(compraSelecionada: compra);

                    Navigator.pop(context);
                  },
                  child: Text(textoSalvarAtualizar))
            ],
          );
        });
  }

  _recuperarCompra() async {
    List anotacoesRecuperadas = await _db.recuperarCompra();

    List<Compra> listaTemporaria =  <Compra>[];
    for (var item in anotacoesRecuperadas) {
      Compra compra = Compra.fromMap(item);
      listaTemporaria.add(compra);
    }

    setState(() {
      _compras = listaTemporaria;
    });
    List   Temporaria ;

    //print("Lista compras: " + comprasRecuperadas.toString() );
  }

  _salvarAtualizarCompra({required Compra compraSelecionada}) async {
    String mercadoria = _tituloController.text;
    String quantidade = _quantidadeController.text;

    if (compraSelecionada.id > 0) {
      //atualizar
      compraSelecionada.mercadoria = mercadoria;
      compraSelecionada.quantidade = int.parse(quantidade);
      int resultado = await _db.atualizarCompra(compraSelecionada);

    } else {

      //salvar
      Compra compra =  Compra(mercadoria, int.parse(quantidade));
      int resultado = await _db.salvarCompra(compra);
    }

    _tituloController.clear();
    _quantidadeController.clear();

    _recuperarCompra();
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

  _removerCompra(int id) async {
    await _db.removerCompra(id);

    _recuperarCompra();
  }

  @override
  void initState() {
    super.initState();
    _recuperarCompra();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Lista de Compras"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _compras.length,
                  itemBuilder: (context, index) {
                    final compra = _compras[index];

                    return Card(
                      child: ListTile(
                        title: Text(compra.mercadoria),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _exibirTelaCadastro(compra: compra);
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
                                _removerCompra(compra.id);
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
            Compra compra  = new Compra("", 0);
            _exibirTelaCadastro(compra: compra);
          }),
    );
  }
}
