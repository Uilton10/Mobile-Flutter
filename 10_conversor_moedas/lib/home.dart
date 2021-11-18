import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController sValor = TextEditingController();
  TextEditingController nOrigem = TextEditingController();
  List <String>lOrigem = ['Dolar','Real','Euro'];
  String sOrigem = 'Dolar';
  List <String>lDestino = ['Dolar','Real','Euro'];
  String sDestino = 'Real';
  String infoResultado = "";

  void _calcular() {
    setState(() {
      double valor = double.parse(sValor.text);
      double result = 0;
      String infoOrigem =  sOrigem;
      String infoDestino =  sDestino;
      infoResultado = "$valor";
      if (infoOrigem == "Real") {
        if (infoDestino == "Dolar") {
          result = valor / 6;
          infoResultado = "$result";
        }else if (infoDestino == "Euro"){
          result = valor / 8;
          infoResultado = "$result";
        }
      }

      if (infoOrigem == "Dolar") {
        if (infoDestino == "Real") {
          result = valor * 6;
          infoResultado = "$result";
        }else if (infoDestino == "Euro"){
          result = valor * 1.2;
          infoResultado = "$result";
        }
      }

      if (infoOrigem == "Euro") {
        if (infoDestino == "Dolar") {
          result = valor * 0.8;
          infoResultado = "$result";
        }else if (infoDestino == "Real"){
          result = valor * 8;
          infoResultado = "$result";
        }
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
      title: Text("Conversor de Moedas"),
      centerTitle: true,
      foregroundColor: Colors.red,

      backgroundColor: Colors.cyan,
    );
  }

  _corpo() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _campo("Valor: ", sValor),
          _textoTitle("De: "),
          _dropdownEstilizado(lOrigem, sOrigem),
          _textoTitle("Para: "),
          _dropdownEstilizado(lDestino, sDestino),
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
          child: Text("CONVERTER",
          style: TextStyle(color: Colors.white, fontSize: 20.0)),
          color: Colors.lightBlueAccent,
        ),
      ),
    );
  }

  _texto(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 25.0),
    );
  }
  _textoTitle(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.green, fontSize: 25.0),
    );
  }

  _textoTitleDados(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
    );
  }
  _textoInfo(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red, fontSize: 25.0),
    );
  }

  _dropdownEstilizado(lItens, sDefault) {
    return DropdownButton<String>(
      value: sDefault,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          sDefault = newValue!;
        });
      },
      items: lItens
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

}


