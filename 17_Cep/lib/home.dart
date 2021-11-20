import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController cepController = TextEditingController();
  String info_endereco = '';
  String infoCep = '';
  String infoLogradouro = '';
  String infoBairro = '';
  String infoCidade = '';
  String infoEstado = '';
  _recuperarCep() async {
    String url = 'https://viacep.com.br/ws/${cepController.text}/json/';

    print(url);

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];

    setState(() {
      infoCep = 'Cep: ${cepController.text}';
      infoLogradouro = 'Logradouro: $logradouro';
      infoBairro = 'Bairro: $bairro';
      infoCidade = 'Cidade: $localidade';
      infoEstado = 'Estado: $uf';

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CEP X Endereço"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Digite o CEP",
                  labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
              controller: cepController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Container(
                height: 100.0,
                child: RaisedButton(
                  onPressed: _recuperarCep,
                  child: Text("Obter endereço",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  color: Colors.blue,
                ),
              ),
            ),
            _texto(infoCep),
            _texto(infoLogradouro),
            _texto(infoBairro),
            _texto(infoCidade),
            _texto(infoEstado),
          ],
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
}
