import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSwitchedDia = false;
  bool isSwitchedFonte = false;
  final longString = 'Lorem ipsum dolor sit amet, consectetur adipiscing '
      'elit, sed do eiusmod tempor incididunt ut labore et dolore magna '
      'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco '
      'laboris nisi ut aliquip ex ea commodo consequat. ';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSwitchValues();
  }


double _getSize(){
    if (isSwitchedFonte) {
      return 10.0;
    }else{
    return 20.0;
    }
}

Color _getColorBack(){
  if (isSwitchedDia) {
    return Colors.white;
  }else{
    return Colors.black;
  }
}
  Color _getColorFonte(){
    if (isSwitchedDia) {
      return Colors.black;
    }else{
      return Colors.white;
    }

  }

  getSwitchValues() async {
    isSwitchedDia = await getSwitchStateDia();
    isSwitchedFonte = await getSwitchStateFonte();
    setState(() {});
  }

  Future<bool> saveSwitchStateDia(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchStateDia", value);
    print('Switch Value saved $value');
    return prefs.setBool("switchStateDia", value);
  }

  Future<bool> saveSwitchStateFonte(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchStateFonte", value);
    print('Switch Value saved $value');
    return prefs.setBool("switchStateDia", value);
  }

  Future<bool> getSwitchStateDia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchStateDia")!;
    print(isSwitchedFT);
    return isSwitchedFT;
  }

  Future<bool> getSwitchStateFonte() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchStateFonte")!;
    print(isSwitchedFT);
    return isSwitchedFT;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frases"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[

            Row(
              children: <Widget>[
                Text(
                  "Dia",
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: isSwitchedDia,
                  onChanged: (bool value) {
                    setState(() {
                      isSwitchedDia = value;
                      saveSwitchStateDia(value);
                      print('Saved state is $isSwitchedDia');
                      //switch works
                    });
                    print(isSwitchedDia);
                  },
                  activeTrackColor: Colors.amberAccent,
                  activeColor: Colors.blue[500],
                ),
                Text(
                  "Pequeno",
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: isSwitchedFonte,
                  onChanged: (bool value) {
                    setState(() {
                      isSwitchedFonte = value;
                      saveSwitchStateFonte(value);
                      print('Saved state is $isSwitchedFonte');
                      //switch works
                    });
                    print(isSwitchedFonte);
                  },
                  activeTrackColor: Colors.amberAccent,
                  activeColor: Colors.blue[500],
                ),
              ],
            ),
      Container(
          decoration: new BoxDecoration(color: _getColorBack()),
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
      Row(
        children: <Widget>[

          Expanded(child: Text("Tempo é aquilo que o homem está sempre tentando matar, mas que no fim acaba matando-o. É preciso escolher um caminho que não tenha fim, mas, ainda assim, caminhar sempre na expectativa de encontrá-lo. A morte não é o fim."
          ,

            style: TextStyle(fontSize: _getSize(),
                color : _getColorFonte())),
          )
  ]
          ),
        ]
      )
      )
          ]
      )
    )
    );
  }
}



