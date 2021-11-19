import 'package:flutter/material.dart';

class Pessoal extends StatelessWidget {
  const Pessoal({Key? key}) : super(key: key);

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
          _textoTitleDados("Pessoal"),
          _texto(""),
          _texto("Nome: Uilton Santos do Amaral"),
          _texto("Endereço: Rua Adelina de Oliveira Soares"),
          _texto("Cidade: Praia Grande"),
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
