import 'dart:ui';

import 'package:my_flutter_delivery_app/Services/LivreurDash.dart';
import 'package:my_flutter_delivery_app/Models/Order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database.dart';

// ignore: must_be_immutable
class MiseLivraisonPage extends StatefulWidget {
  Order _order;
  MiseLivraisonPage(this._order);
  @override
  _MiseLivraisonPageState createState() => _MiseLivraisonPageState();
}

class _MiseLivraisonPageState extends State<MiseLivraisonPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  bool _autovalidate = false;
  bool orderReceived = false;
  DatabaseProvider db = new DatabaseProvider();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = widget._order.nomPrenoms;
    phoneController.text = widget._order.customerPhone;
    super.initState();
  }

  void verfyForm() async {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      if (orderReceived) {
        widget._order.orderStat = "1";
        await db.updateOrder(widget._order);
        Navigator.push(
            context,
            MaterialPageRoute (
                builder: (BuildContext context) => LivreurDash()));
      } else {
        final snackBar = SnackBar(content: Text('Veuillez confirmer la reception'));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    } else {
      setState(() {
        this._autovalidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeighSize = MediaQuery.of(context).size.height;
    double screenWidthSize = MediaQuery.of(context).size.width;
    return Scaffold (
        backgroundColor: Colors.white,
        appBar: new AppBar (
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.black),
          elevation: 0.0,
        ),
        body: Container (
          child: ListView (
            children: <Widget> [
              SizedBox(
                height: (screenHeighSize * 0.01),
              ),
              Form(
                  key: this._formKey,
                  autovalidate: _autovalidate,
                  child: Padding (
                    padding: const EdgeInsets.all(10.0),
                    child: Container (
                      width: (screenWidthSize * 0.1),
                      child: Column (
                        mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [
                          new TextFormField (
                            style: TextStyle(color: Colors.black),
                            decoration: new InputDecoration (
                              labelText: 'Nom Prénoms ',
                              labelStyle: TextStyle(color: Colors.black), //     icon: Icon(Icons.account_box),
                              border: UnderlineInputBorder (
                                  borderSide: BorderSide(width: 4)),
                            ),
                            controller: this.nameController,
                            validator: (String val) {
                              if (val.length == 0) {
                                return "Désolé mais ce champs ne doit pas etre vide";
                              } else {
                                nameController.text = val;
                                return null;
                              }
                              },
                          ),
                        SizedBox(
                          width: double.maxFinite,
                          height: 40.0,
                        ),
                        new TextFormField(
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.numberWithOptions( signed: true,
                            ),
                            maxLength: 8, // Use email input type for emails.
                            decoration: new InputDecoration (
                              labelText: 'Téléphone', // icon: Icon(Icons.phone),
                              border: UnderlineInputBorder (
                                  borderSide: BorderSide (
                                      color: Theme.of(context).primaryColor)),
                            ),
                            controller: this.phoneController,
                            validator: (String phone) {
                              if (phone.length < 8) {
                                return "Le numéro de téléphone doit avoir au moins 8 chiffres";
                              } else {
                                phoneController.text = phone;
                                return null;
                              }
                            }),
                        SizedBox(
                          width: double.maxFinite,
                          height: 20.0,
                        ),
                        Row (
                          children: <Widget> [
                            Text("Confirmer la recepMon"),
                            Checkbox (
                                value: orderReceived,
                                onChanged: (bool val) {
                                  if (val) {
                                    setState(() {
                                      orderReceived = true;
                                    });
                                  } else {
                                    setState(() {
                                      orderReceived = false;
                                    });
                                  }
                                }),
                          ],
                        ),
                        SizedBox (
                          width: double.maxFinite,
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            verfyForm();
                            },
                          child: Material(
                              color: Theme.of(context).primaryColor,
                              elevation: 2.0,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                height: 50,
                                width: 200,
                                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 80),
                                child: Center(
                                  child: Text(
                                    "Valider",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                ),
                              )),
                        )
                      ],
                      ),
                    ),
                  )
              )
            ],
          ),
        )
    );
  }
}