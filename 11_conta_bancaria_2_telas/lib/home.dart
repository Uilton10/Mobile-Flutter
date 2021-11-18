import 'package:flutter/material.dart';
import 'pages/Result.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController sNome = TextEditingController();
  TextEditingController nIdade = TextEditingController();
  List <String>lSexo = ['Masculino','Feminino'];
  String sSexo = 'Masculino';
  List <String>lEscolaridade = ['Ensino Medio Incompleto','Ensino Medio Completo','Ensino Superior Incompleto','Ensino Superior Completo'];
  String sEscolaridade = 'Ensino Medio Incompleto';
  String infoResultado = "";
  String infoDadosTitle = "";
  String infoNome = "";
  String infoIdade = "";
  String infoSexo = "";
  String infoEscolaridade = "";
  String infoLimite = "";
  String infoBrasileiro = "";
  double nLimite = 0;
  double nValorSlicer = 0;
  bool valorSwitch = false;

  void _calcular() {
    setState(() {
      String nome = sNome.text;
      String idade = nIdade.text;

      infoDadosTitle = "Dados informados";
      infoNome = "Nome: "+nome ;
      infoIdade = "Idade: "+ idade;
      infoSexo = "Sexo: "+ sSexo;
      infoEscolaridade = "Escolaridade: "+ sEscolaridade;
      infoLimite = "Limite: "+ nValorSlicer.toString();
      if (valorSwitch = true) {
        infoBrasileiro = "Brasileiro: Sim";
      }else{
        infoBrasileiro = "Brasileiro: Não";
      }

    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Result(infoDadosTitle: infoDadosTitle, infoNome: infoNome,
              infoIdade: infoIdade, infoSexo: infoSexo,
              infoEscolaridade: infoEscolaridade, infoLimite: infoLimite,
              infoBrasileiro: infoBrasileiro);
        },
      ),
    );

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
      title: Text("Abertura de Conta"),
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
          _campo("Nome: ", sNome),
          _campo("Idade: ", nIdade),
          _textoTitle("Sexo"),
          _dropdownEstilizado(lSexo, sSexo),
          _textoTitle("Escolaridade"),
          _dropdownEstilizado(lEscolaridade, sEscolaridade),
          _textoTitle("Limite"),
          _slider(nLimite),
          _textoInfo(nValorSlicer.toString()),
          _textoTitle("Brasileiro"),
          _switch(),
          _botao(),

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


  _textoTitle(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.green, fontSize: 25.0),
    );
  }


  _textoInfo(textoParaExibir) {
    return Text(
      textoParaExibir,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red, fontSize: 25.0),
    );
  }

  _dropdownEstilizado(lSexo, sDefault) {
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
      items: lSexo
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _slider(returnValor) {
    return Slider(
      value: nValorSlicer,
      min: 0,
      max: 10000,
      divisions: 100,
      label: nValorSlicer.round().toString(),
      onChanged: (double value) {
        setState(() {
          nValorSlicer = value;
        });
      },
    );
  }

  _switch() {
    return Switch(
      value: valorSwitch,
      onChanged: (value) {
        setState(() {
          valorSwitch = value;
        });
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.blue,
    );
  }

}


