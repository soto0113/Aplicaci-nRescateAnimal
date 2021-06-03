import 'dart:io';
import 'package:animalrescue/identificacionA.dart';
import 'package:animalrescue/reporteA.dart';
import 'package:animalrescue/situacionA.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animalrescue/login_and_register.dart';

void main() => runApp(Gym());

class Gym extends StatefulWidget {
  const Gym({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => _GymState();
}

class _GymState extends State<Gym> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  // Cerrar sesión
  _signOut() async {
    await _auth.signOut();
    runApp(new MaterialApp(
      home: new LoginSignUpPage(),
    ));
  }

  // muestra el menu y una lista con varios enlaces a otras ventanas
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('ANIMAL RESCUE'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.add),
                    title: Text(
                      'Identificación',
                    ),
                    subtitle: Text('Descripción del aspecto fisico del animal'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new identificacion()));
                    },
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.add),
                    title: Text(
                      'Situación del animal',
                    ),
                    subtitle: Text('Relaciona en que estado se encuentra el animal'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new situacionA()));
                    },
                  )
                ],
              ),
            ),
             Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.add),
                    title: Text(
                      'Reporte del animal encontrado',
                    ),
                    subtitle: Text('Envia los datos de la ubicación del animal'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new reporteA()));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage:AssetImage("imagenes/animal.png"),
              ),
              accountEmail: Text("${user?.email}"),
              accountName: null,
            ),
            ListTile(
              title: Text('Identificación'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>new identificacion()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Situación'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new situacionA()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Reporte'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new reporteA()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
                title: Text('Cerrar sesión'),
                onTap: () {
                  _signOut();
                  exit(0);
                })
          ],
        ),
      ),
    );
  }
}