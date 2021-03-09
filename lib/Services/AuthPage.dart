import 'dart:async';

import 'package:my_flutter_delivery_app/Models/Livreur.dart';
import 'package:my_flutter_delivery_app/Models/Order.dart';
import 'package:my_flutter_delivery_app/Models/Receptionnaire.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'LivreurDash.dart';
import 'database.dart';

// ignore: must_be_immutable
class AuthPage extends StatefulWidget {
  AuthPage({Key key, this.title}) : super(key: key);
  final String title;
  String livreurId;
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = new  GlobalKey<FormState>();
  bool _autovalidate = false;
  String resultText = "Bienvenue";
  DatabaseProvider db = new DatabaseProvider();
  TextEditingController loginController = new TextEditingController();
  TextEditingController passWordController = new  TextEditingController();
  Livreur livreur, livreur1, livreur2, livreur3;
  Receptionnaire receptionnaireBah, receptionnaireKoffi, receptionnaireJove, receptionnaireDine, receptionnairePapa;
  Order orderNike, orderLacoste, orderBlueJean, orderChapeau, orderWatch, orderBag, orderCostume, orderPantalon;

  @override
  void initState() {
    db.create();
    startime();
    super.initState();
  }

  startime() async {
    var _duration = new Duration(seconds: 10);
    return Timer(_duration, loadInformation);
  }

  loadInformation() async {
    livreur1 = new Livreur(0, "Livreur 1", "Livreur109876");
    livreur2 = new Livreur(1, "Livreur 2", "Livreur212345");
    livreur3 = new Livreur(2, "Livreur 3", "Livreur3@&#*£");
    await db.insertLivreur(livreur1);
    await db.insertLivreur(livreur2);
    await db.insertLivreur(livreur3);

    receptionnaireKoffi = new Receptionnaire(0, "Koffi Kim", "90123456");
    receptionnaireJove = new Receptionnaire(1, "Mac Jove", "91234567");
    receptionnaireBah = new Receptionnaire(2, "Bah Gloria", "92345678");
    receptionnaireDine = new Receptionnaire(3, "Dine Boss", "93456789");
    receptionnairePapa = new Receptionnaire(4, "Papa Codjo", "94567890");
    await db.insertReceptionnaire(receptionnaireKoffi);
    await db.insertReceptionnaire(receptionnaireJove);
    await db.insertReceptionnaire(receptionnaireBah);
    await db.insertReceptionnaire(receptionnaireDine);
    await db.insertReceptionnaire(receptionnairePapa);

    orderNike = new Order(0, "Bah Gloria", "Nike", "0", "92345678", 50000);
    orderLacoste = new Order(1, "Mac Jove", "Lacoste", "0", "91234567", 25000);
    orderBlueJean = new Order(2, "Dine Boss", "Blue Jean", "0", "93456789", 78000);
    orderChapeau = new Order(3, "Koffi Kim", "Chapeau", "0", "90123456", 7500);
    orderWatch = new Order(4, "Mac Jove", "Watch", "0", "91234567", 15000);
    orderBag = new Order(5, "Koffi Kim", "Bag", "0", "90123456", 5000);
    orderCostume = new Order(6, "Papa Codjo", "Costume", "0", "94567890", 45000);
    orderPantalon = new Order(7, "Bah Gloria", "Pantalon", "0", "92345678", 35000);
    await db.insertOrder(orderNike);
    await db.insertOrder(orderLacoste);
    await db.insertOrder(orderBlueJean);
    await db.insertOrder(orderChapeau);
    await db.insertOrder(orderWatch);
    await db.insertOrder(orderBag);
    await db.insertOrder(orderCostume);
    await db.insertOrder(orderPantalon);
  }

  void verifyForm() async {// First validate form.
    if (this._formKey.currentState.validate()) {
      db.getLivreur(int.parse(widget.livreurId)).then((livreurGet) {
      setState(() {
        if (livreurGet != null) {
          livreur = livreurGet;
        }
      });
    });

    if (loginController.text == livreur1.login && passWordController.text == livreur1.password) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LivreurDash()));
    }
    else if (loginController.text == livreur2.login && passWordController.text == livreur2.password) {
      Navigator.push (
          context,
          MaterialPageRoute (
              builder: (BuildContext context) => LivreurDash()));
    }
    else if (loginController.text == livreur3.login && passWordController.text == livreur3.password) {
      Navigator.push (
          context,
          MaterialPageRoute (
              builder: (BuildContext context) => LivreurDash()));
    }
    else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erreur d'authentification"),
              content: Text(
                'Le nom d\'authentification ou le mot de passe incorrect', textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            );
          });
    }
    } else {
      setState(() {
        this._autovalidate = true;
      });
    }
  }

  Future _scanQRCode() async {
    try {
      String qrCodeResult = (await BarcodeScanner.scan()) as String;
      setState(() {
        resultText = qrCodeResult;

        if (resultText == "Livreur 1") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LivreurDash()));
        }
        else if (resultText == "Livreur 2") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LivreurDash()));
        }
        else if (resultText == "Livreur 3") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LivreurDash()));
        }
        else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Authentification par Code QR échouée"),
                  content: Text(
                    "Code QR incorrect",
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK"))
                  ],
                );
              });
        }
      }
      );
    }
    on FormatException {
      setState(() {
        resultText = "Cliquer sur le boutton retour";
      });
    } catch (ex) {
      setState(() {
        resultText = "Erreur inconnue $ex ";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text ("Connexion"),
    ),
        body: ListView (
          children: <Widget> [
            SizedBox(),
            Form (
                key: this._formKey,
                autovalidate: _autovalidate,
                child: Padding (
                  padding: const EdgeInsets.all(10.0),
                  child: Container (
                    width: 100,
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        SizedBox (
                          width: double.maxFinite,
                          height: 30.0,
                        ),
                        new TextFormField (
                          style: TextStyle(color: Colors.black),
                          decoration: new InputDecoration (
                            labelText: 'Login ',
                            labelStyle: TextStyle (
                                color: Colors.black),
                            //     icon: Icon(Icons.account_box),
                            border: UnderlineInputBorder (
                                borderSide: BorderSide(width: 4)),
                          ),
                          controller: this.loginController,
                          validator: (String val) {
                            if (val.length == 0) {
                              return "Ce champs ne doit pas etre vide";
                            }
                            else {
                              loginController.text = val;
                              return null;
                            }
                            },
                        ),
                        SizedBox (
                          width: double.maxFinite,
                          height: 40.0,
                        ),
                        new TextFormField (
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: new InputDecoration(
                            labelText: 'Password ',
                            labelStyle: TextStyle(color: Colors.black), //     icon: Icon(Icons.account_box), border: UnderlineInputBorder( borderSide: BorderSide(width: 4)),
                          ),
                          controller: this.passWordController,
                          validator: (String val) {
                            if (val.length == 0) {
                              return "Veuillez saisir un mot de passe correcte";
                            } else {
                              passWordController.text = val;
                              return null;
                            }
                            },
                        ),
                        SizedBox (
                          width: double.maxFinite,
                          height: 30.0,
                        ),
                        InkWell (
                          onTap: () {
                            verifyForm();
                            },
                          child: Material(
                              color: Theme.of(context).primaryColor,
                              elevation: 2.0,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              child: Container (
                                height: 50,
                                width: 200,
                                child: Center (
                                  child: Text(
                                    "Connexion",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox (
                          width: double.maxFinite,
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended (
          icon: Icon(Icons.camera_alt),
          label: Text("Scanner Code QR"),
          onPressed: _scanQRCode,
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}