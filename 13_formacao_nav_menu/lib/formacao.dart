import 'package:flutter/material.dart';

class Formacao extends StatelessWidget {
  const Formacao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          _textoTitleDados("Formação"),
          _texto(""),
          _texto("Escolaridade: Superior Incompleto"),
          _texto(""),
          _textoTitleDados("Cursos"),
          _texto("ETEC - PRAIA GRANDE"),
          _texto("CURSO: Informática"),
          _texto("Concluido em : 2008"),
        ],
      ),
    );
  }

  _textoTitleDados(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
    );
  }

  _texto(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 25.0),
    );
  }
}
