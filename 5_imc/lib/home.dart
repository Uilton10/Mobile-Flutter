import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nPeso = TextEditingController();
  TextEditingController nAltura = TextEditingController();

  String infoResultado = "Informe os valores!";

  void _calcular() {
    setState(() {
      double npeso = double.parse(nPeso.text);
      double naltura = double.parse(nAltura.text);
      double imc = 0;
      if (naltura > 0 && npeso > 0){
         imc = npeso / (naltura*naltura);
        if (imc < 18.5){
          infoResultado = "Abaixo do Peso";
        }else if(imc <= 25){
          infoResultado = "Peso Normal";
        }else if(imc <= 30){
          infoResultado = "Sobrepeso";
        }else if(imc <= 35){
          infoResultado = "Obesidade Grau 1";
        }else if(imc <= 40){
          infoResultado = "Obesidade Grau 2";
        }else{
          infoResultado = "Obesidade Grau 3 ou Mórbida";
        }

      }else{
        infoResultado = "Não é possivel realizar o cálculo do IMC";
      }
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
      title: Text("Calculo do IMC"),
      centerTitle: true,
      backgroundColor: Colors.greenAccent,
    );
  }

  _corpo() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _foto(),
          _campo("Digite o seu peso", nPeso),
          _campo("Digite a sua altura", nAltura),
          _botao(),
          _texto(infoResultado),
        ],
      ),
    );
  }

  _campo(labelTitulo, objController) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: labelTitulo, labelStyle: TextStyle(color: Colors.green)),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green, fontSize: 25.0),
      controller: objController,
    );
  }

  _botao() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Container(
        height: 50.0,
        child: RaisedButton(
          onPressed: _calcular,
          child: Text("VERIFICAR",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          color: Colors.lightBlueAccent,
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
_foto() {
  return Center(
    child: Image.network(
      'https://ichef.bbci.co.uk/news/800/cpsprodpb/15E02/production/_104620698_prmo_imc_br-nc.png',
      height: 150,
      width: 150,
    ),
  );
}

