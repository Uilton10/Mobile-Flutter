import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String infoResultado = "";
  String infoTitulo = "Anúncios";
  void _calcular() {
    setState(() {
      int naleatorio =  new Random().nextInt(10);
      infoResultado = naleatorio.toString();
    });
  }

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
      title: Text("Jogo Número Aleatorio"),
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
            _texto("Anúncios"),
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
    margin: EdgeInsets.only(top: 20, bottom: 20, left: 100),
    height: 600,
    width: 300,
    alignment: Alignment.center,
    child: PageView(
      children: <Widget>[
        _infoCarroucel('heineken.png','Heineken', '5,00'),
        _infoCarroucel('skol.png','Skol', '2,00'),
      ],
    ),
  );
}
_infoCarroucel(nameImage, nameCerva, precoCerva){
  return SingleChildScrollView(
    child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _foto(nameImage),
          _texto(nameCerva),
          _texto(precoCerva)
        ],
      ),
    ),
  );
}

  _texto(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red, fontSize: 25.0),
    );
  }
}

_foto(String nomeFoto) {
  return Image.asset(
    "assets/images/$nomeFoto",
    height: 300,
    width: 300,
    fit: BoxFit.fill,
    //fit: BoxFit.contain,
    //fit: BoxFit.cover,
  );
}


