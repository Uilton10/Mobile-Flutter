import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TelaInicial();
  }
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  TextEditingController nomeController = TextEditingController();

  String exibicaoNome = "";
  int contPessoa = 0;
  void _soma() {
    setState(() {
      String nome = nomeController.text;
      contPessoa = contPessoa + 1;
      exibicaoNome = "$contPessoa";
    });
  }

  void _subtrai() {
    setState(() {
      String nome = nomeController.text;
      contPessoa = contPessoa - 1;
      exibicaoNome = "$contPessoa";
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Contador de Pessoas"),
          centerTitle: true,
        ),
        body: _body(),
      ),
    );
  }

  _body() {
    return Container(
      width: double.infinity,
      color: Colors.white10,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _texto("Contador de Pessoas"),
          _texto(exibicaoNome),
          _buttonSoma(),
          _buttonDiminui(),

        ],
      ),
    );
  }

  _campo() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "",
          labelStyle: TextStyle(color: Colors.green)),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green, fontSize: 25.0),
      controller: nomeController,
    );
  }


  _texto(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red, fontSize: 60),
    );
  }


  _buttonSoma() {
    return RaisedButton(
      color: Colors.green,
      //onPressed: null,
      //onPressed: () {
      //print("Okay!");
      //},
      onPressed: _soma,
      child: Text(
        "+",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }


  _buttonDiminui() {
  return RaisedButton(
    color: Colors.green,
    //onPressed: null,
    //onPressed: () {
    //print("Okay!");
    //},
    onPressed: _subtrai,
    child: Text(
    "-",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  );
}
}
