import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class situacionA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AddReporte(String situacion) async {
      String userEmail;

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userEmail = user.email;
      Firestore.instance.collection('SituacionAnimal').document(userEmail)
      .setData({'Correo':userEmail,'Situación':situacion
      });
    }

    final myControllerS = TextEditingController();
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Situación del animal"),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Image.asset(
              'imagenes/animal.png',
              width: 300.0,
              height: 240.0,
              fit: BoxFit.cover,
          ),
          SizedBox(height: 30.0),
          TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: myControllerS,
              decoration: new InputDecoration(
                hintText: 'Situación del animal',
                      icon: new Icon(
                        Icons.pets_sharp,
                        color: Colors.orangeAccent
                      ),
                border: InputBorder.none,
              ),
              validator: (value) =>
                  value.isEmpty ? 'El campo no puede estar vacio' : null,
              onSaved: (value) => value,
          ),
          SizedBox(height: 30.0),
          RaisedButton(
              elevation: 4.0,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(29.0)),
              color: Colors.orangeAccent,
                  onPressed: () {
                    AddReporte(myControllerS.text);
                    Navigator.pop(context, false);
                  },
                  
              child: Row(
                  children: <Widget>[
                  Text('             Guardar ', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  Icon(Icons.save, color: Colors.black,),
                  ],
              ),
          ),
         ]),
      ),
    );
  }
}
