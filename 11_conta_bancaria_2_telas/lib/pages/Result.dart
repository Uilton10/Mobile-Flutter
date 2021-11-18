import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  String infoDadosTitle;
  String infoNome;
  String infoIdade;
  String infoSexo;
  String infoEscolaridade;
  String infoLimite;
  String infoBrasileiro;
  Result({required this.infoDadosTitle, required this.infoNome,
    required this.infoIdade, required this.infoSexo,
    required this.infoEscolaridade, required this.infoLimite,
    required this.infoBrasileiro });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          _textoTitleDados(infoDadosTitle),
          _texto(infoNome),
          _texto(infoIdade),
          _texto(infoSexo),
          _texto(infoEscolaridade),
          _texto(infoLimite),
          _texto(infoBrasileiro),
          RaisedButton(
            child: Text('Voltar'),
            onPressed: () => _onClickVoltar(context),
          ),
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

  _onClickVoltar(BuildContext context) {
    Navigator.pop(context);
  }
}

