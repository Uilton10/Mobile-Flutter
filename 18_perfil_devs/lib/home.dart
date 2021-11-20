import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController userController = TextEditingController();
  String info_id = '';
  String info_nome = '';
  String info_repositorios = '';
  String info_criado = '';
  String info_seguidores = '';
  String info_seguindo = '';
  String photo = '';
  _recuperaUser() async {
    String url = 'https://api.github.com/users/${userController.text}';

    print(url);

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    int id = retorno["id"];
    String nome = retorno["name"];
    int repositorios = retorno["public_repos"];
    String criado = retorno["created_at"];
    int seguidores = retorno["followers"];
    int seguindo = retorno["following"];
     photo  = retorno["avatar_url"];
    setState(() {
      info_id =  'Id: ${id.toString()}';
       info_nome =  'Nome: ${nome}';
       info_repositorios =  'Repositorios:  ${repositorios}';
       info_criado =  'Criado em: ${criado}';
       info_seguidores = 'Seguidores: ${seguidores}';
       info_seguindo =  'Seguindo: ${seguindo}';

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil dos Devs"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            _foto(),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Digite o login git",
                  labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
              controller: userController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Container(
                height: 100.0,
                child: RaisedButton(
                  onPressed: _recuperaUser,
                  child: Text("Obter dados",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  color: Colors.blue,
                ),
              ),
            ),
            _texto(info_id),
            _texto(info_nome),
            _texto(info_repositorios),
            _texto(info_criado),
            _texto(info_seguidores),
            _texto(info_seguindo),
          ],
        ),
      ),
    );
  }
  _texto(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 10),
    );
  }

  _foto() {
    return Center(
      child: Image.network(
        photo,
        height: 150,
        width: 150,
      ),
    );
  }
}
