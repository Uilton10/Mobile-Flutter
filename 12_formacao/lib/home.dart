
import 'package:flutter/material.dart';
import 'pessoal.dart';
import 'formacao.dart';
import 'experiencia.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;

  final telas = [
    Center(child: Text('Tela Home')),
    Pessoal(),
    Formacao(),
    Experiencia(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _titulo(),
        backgroundColor: Colors.white,
        body: telas[_currentPage],
        drawer: Drawer(
            child: ListView(
              children: [
                FlutterLogo(size: 50),
                UserAccountsDrawerHeader(

                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/uilton.jpg'),
                  ),
                  accountName: Text('Uilton Amaral'),
                  accountEmail: Text('uilton.amaral@gmail.com'),
                ),

                ListTile(
                  //leading: Icon(Icons.star),
                  title: Text('Home'),
                  subtitle: Text('Tela inicial do App'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    setState(() {
                      _currentPage = 0;
                    });
                  },
                ),
                ListTile(
                  //leading: Icon(Icons.star),
                  title: Text('Pessoal'),
                  trailing: Icon(Icons.account_box_outlined),
                  onTap: () {
                    setState(() {
                      _currentPage = 1;
                    });
                  },
                ),
                ListTile(
                  //leading: Icon(Icons.star),
                  title: Text('Formação'),
                  trailing: Icon(Icons.contact_mail_rounded),
                  onTap: () {
                    setState(() {
                      _currentPage = 2;
                    });
                  },
                ),
                ListTile(
                  //leading: Icon(Icons.star),
                  title: Text('Experiência'),
                  trailing: Icon(Icons.contact_mail_rounded),
                  onTap: () {
                    setState(() {
                      _currentPage = 3;
                    });
                  },
                )
              ],
            )),
      ),
    );
  }
  _titulo() {
    return AppBar(
      title: Text("Meu Perfil"),
      centerTitle: true,
      backgroundColor: Colors.green,
    );
  }
}


