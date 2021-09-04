import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nGasolina = TextEditingController();
  TextEditingController nAlcool = TextEditingController();

  String infoResultado = "Informe os números!";

  void _calcularSoma() {
    setState(() {
      double ngasolina = double.parse(nGasolina.text);
      double nalcool = double.parse(nAlcool.text);

      if (ngasolina > 0){
        double resultado = nalcool/ngasolina;
        if (resultado <= 0.7){
          infoResultado = "Melhor por alcool";
        }else{
          infoResultado = "Melhor colocar gasolina";
        }
      }else{
        infoResultado = "Não é possivel realizar o cálculo";
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
      title: Text("Somador de Números"),
      centerTitle: true,
      backgroundColor: Colors.green,
    );
  }

  _corpo() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _foto(),
          _campo("Digite o valor da Gasolina", nGasolina),
          _campo("Digite o valor do Alcool", nAlcool),
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
          onPressed: _calcularSoma,
          child: Text("CALCULAR",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          color: Colors.green,
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
      'https://complemento.veja.abril.com.br/economia/calculadora-combustivel/img/abre.jpg',
      height: 150,
      width: 150,
    ),
  );
}

