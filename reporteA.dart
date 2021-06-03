import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class reporteA extends StatefulWidget {
  const reporteA({ Key key }) : super(key: key);

  @override
  _reporteAState createState() => _reporteAState();
}

class _reporteAState extends State<reporteA> {
  var imageFile;
  @override
  Widget build(BuildContext context) {
    AddReporte(String ubicacion, String descripcion) async {
      String userEmail;

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userEmail = user.email;
      Firestore.instance.collection('ReporteAnimal').document(userEmail)
      .setData({'Ubicación':ubicacion, 'Descripción': descripcion 
      });
    }
    
    final myControllerU = TextEditingController();
//    final myControllerF = TextEditingController();
    final myControllerD = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte"),
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
              controller: myControllerU,
              decoration: new InputDecoration(
                hintText: 'Ubicación del animal',
                      icon: new Icon(
                        Icons.directions,
                        color: Colors.orangeAccent
                      ),
                border: InputBorder.none,
              ),
              validator: (value) =>
                  value.isEmpty ? 'El campo no puede estar vacio' : null,
              onSaved: (value) => value,
          ),
          SizedBox(height: 30.0),
          _setImageView(),
          FloatingActionButton(
            
            onPressed: () {
            _showSelectionDialog(context);
            
          },
            child: 
            Icon(Icons.camera_alt),
          ),
          SizedBox(height: 30.0),
          TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: myControllerD,
              decoration: new InputDecoration(
                hintText: 'Descripción',
                      icon: new Icon(
                        Icons.description,
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
                    AddReporte(myControllerU.text,myControllerD.text);
                    Navigator.pop(context, false);
                  },
                  
              child: Row(
                  children: <Widget>[
                  Text('     Enviar Información ', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  Icon(Icons.save, color: Colors.black,),
                  ],
              ),
          ),
         ]),
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("De donde quieres subir la foto?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Galeria"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camara"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(imageFile, width: 100, height: 100);
    } else {
      return Text("Sube una foto");
    }
  }
}


/*
class reporteA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AddReporte(String ubicacion, String foto, String descripcion) async {
      String userEmail;

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      userEmail = user.email;
      Firestore.instance.collection('ReporteAnimal').document(userEmail)
      .setData({'Ubicación':ubicacion,'foto':foto, 'Descripción': descripcion 
      });
    }

    final myControllerU = TextEditingController();
    final myControllerF = TextEditingController();
    final myControllerD = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte"),
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
              controller: myControllerU,
              decoration: new InputDecoration(
                hintText: 'Ubicación del animal',
                      icon: new Icon(
                        Icons.directions,
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
                    Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new PhotoPreviewScreen()));
                  },
              child: Row(
                  children: <Widget>[
                  Text('     Foto ', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  Icon(Icons.photo, color: Colors.black,),
                  ],
              ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: myControllerD,
              decoration: new InputDecoration(
                hintText: 'Descripción',
                      icon: new Icon(
                        Icons.description,
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
                    AddReporte(myControllerU.text,myControllerF.text,myControllerD.text);
                    Navigator.pop(context, false);
                  },
                  
              child: Row(
                  children: <Widget>[
                  Text('     Enviar Información ', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  Icon(Icons.save, color: Colors.black,),
                  ],
              ),
          ),
         ]),
      ),
    );
  }
}
*/