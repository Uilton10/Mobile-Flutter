import 'package:flutter/material.dart';
import 'package:teste01/Filme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _sinopseController = TextEditingController();

  List<Filme> _filmes = <Filme>[];

  _exibirTelaCadastro({required Filme filme}) {
      _nomeController.text = filme.nome;
      _sinopseController.text = filme.sinopse;


    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("APP de Filmes"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _textoTitle(_nomeController.text + ' - Sinopse'),
                _texto(''),
                _texto(''),
                _texto(_sinopseController.text)
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Fechar")),
            ],
          );
        });
  }

  _recuperarFilmes() async {
    http.Response response =
    await http.get(Uri.parse('https://sujeitoprogramador.com/r-api/?api=filmes'));

    var dadosJson = json.decode(response.body);

    List<Filme> filmes = <Filme>[];
    print('---------------aqui 1');

    for (var filme in dadosJson) {
      print("nome: " + filme["nome"]);
      Filme f = Filme(filme["id"], filme["nome"], filme["sinopse"], filme["foto"]);
      filmes.add(f);
    }
    setState(() {
      _filmes = filmes;
    });
    print(_filmes);
  }


  @override
  void initState() {
    super.initState();
    _recuperarFilmes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Filmes"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _filmes.length,
                  itemBuilder: (context, index) {
                    final filme = _filmes[index];

                    return Card(
                      child: ListTile(
                        title: _textoTitle(filme.nome),
                        subtitle: _foto(filme.foto),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _exibirTelaCadastro(filme: filme);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Text('Ver mais')
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  _foto(imFoto) {
    return Center(
      child: Image.network(
        imFoto,
        height: 200,
        width: 300,
      ),
    );
  }
  _texto(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.justify,
      style: TextStyle(color: Colors.black, fontSize: 15.0 ),
    );
  }

  _textoTitle(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold ),
    );
  }
}
