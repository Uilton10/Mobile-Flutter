import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String infoResultado = "";
  String infoTitulo = "Vagas";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _titulo(),
      backgroundColor: Colors.white,
      body: _corpo(),
    );
  }

  _titulo() {
    return AppBar(
      title: Text("Vagas de Empergo"),
      centerTitle: true,
      backgroundColor: Colors.black,
    );
  }

  _corpo() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _texto("Vagas de Emprego", Colors.red),
            _carrosel()
          ],
        ),
      ),
    );

  }

  _campo(labelTitulo, objController) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: labelTitulo, labelStyle: TextStyle(color: Colors.blue)),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
      controller: objController,
    );
  }



 
_carrosel() {
  return Container(
    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20),
    height: 600,
    width: 300,
    alignment: Alignment.center,
    child: PageView(
      children: <Widget>[
        _infoCarroucel('Desenvolvedor Backend','3000,00', 'Desenvolver em backend','(11) 9 9999-9999'),
        _infoCarroucel('Engenheiro de Dados','100,00', 'Administrar Banco de Dados','(11) 9 9888-9999'),
      ],
    ),
  );
}
_infoCarroucel(TitleVaga,valSal, descVaga, contato){
  return SingleChildScrollView(
    child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _texto(TitleVaga, Colors.blue),
          _texto("Sálario: RS $valSal", Colors.black),
          _texto("Descrição: $descVaga", Colors.black),
          _texto("Contato: $contato", Colors.black)
        ],
      ),
    ),
  );
}

  _texto(textoParaExibir, cor) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.center,
      style: TextStyle(color: cor, fontSize: 25.0),
    );
  }
}

