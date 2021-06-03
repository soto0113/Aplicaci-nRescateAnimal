import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class identificacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    AddReporte(String tipo, String colorsito, String raza) async {
      String userEmail;

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userEmail = user.email;
      Firestore.instance.collection('Identificación').document(userEmail)
      .setData({'Correo':userEmail,'Tipo':tipo, 'Color': colorsito, 
      'Raza':raza
      });
    }

    final myControllerT = TextEditingController();
    final myControllerC = TextEditingController();
    final myControllerR = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Identificación"),
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
              controller: myControllerT,
              decoration: new InputDecoration(
                hintText: 'Tipo de animal (Gato o Perro)',
                      icon: new Icon(
                        Icons.pets,
                        color: Colors.orangeAccent
                      ),
                border: InputBorder.none,
              ),
              validator: (value) =>
                  value.isEmpty ? 'El campo no puede estar vacio' : null,
              onSaved: (value) => value,
          ),
          SizedBox(height: 30.0),
          TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: myControllerC,
              decoration: new InputDecoration(
                hintText: 'Color del animal',
                      icon: new Icon(
                        Icons.color_lens,
                        color: Colors.orangeAccent
                      ),
                border: InputBorder.none,
              ),
              validator: (value) =>
                  value.isEmpty ? 'El campo no puede estar vacio' : null,
              onSaved: (value) => value,
          ),
          SizedBox(height: 30.0),
          TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: myControllerR,
              decoration: new InputDecoration(
                hintText: 'Raza del animal',
                      icon: new Icon(
                        Icons.select_all,
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
                    AddReporte(myControllerT.text,myControllerC.text,myControllerR.text);
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
