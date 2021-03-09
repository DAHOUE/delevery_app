import 'dart:ui';

import 'package:my_flutter_delivery_app/Models/Order.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'MiseLivraisonPage.dart';

// ignore: must_be_immutable
class DetailCommande extends StatefulWidget {
  DetailCommande(this.orderId, this.mustShowBoson);
  String orderId;
  bool mustShowBoson;
  @override
  _DetailCommandeState createState() => _DetailCommandeState();
}

class _DetailCommandeState extends State<DetailCommande> {
  DatabaseProvider db = new DatabaseProvider();
  Order order;

  @override
  void initState() {
    getOrder();
    super.initState();
  }

  void getOrder() {
    db.getOrder(int.parse(widget.orderId)).then((orderGet) {
      setState(() {
        if (orderGet != null) {
          order = orderGet;
        } else {}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1.0,
        title: Text("Detail de la Livraison"),
      ),
      body: chargerDetail(),
    );
  }

  chargerDetail() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Text("Receptionnaire",
                style: TextStyle(fontSize: 18),
              ),
            Text(order.nomPrenoms)
          ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Text("Produit",
                style: TextStyle(fontSize: 18),
              ),
            Text(order.nomProduit)
          ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Text("Contact",
                style: TextStyle(fontSize: 18),
              ),
            Text(order.customerPhone)
          ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Text("Adresse de livraison",
                style: TextStyle(fontSize: 18),),
            Text("")
          ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Text(
                "Total",
                style: TextStyle(fontSize: 18),
              ),
            Text(order.total.toString())
          ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      widget.mustShowBoson
          ? Center(
        child: roundedRectBuson('Mise en livraison', gradients),
      )
          : Container()
    ],
  );
}

Widget roundedRectBuson(String title, List<Color> gradient) {
    return Builder(builder: (BuildContext mContext) {
      return InkWell(
        onTap: () {
          Navigator.push(
            mContext,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                new MiseLivraisonPage(order)));
      },
      child: Padding(
      padding: EdgeInsets.only(bottom: 10),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(mContext).size.width / 1.7, decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)),
          gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          padding: EdgeInsets.only(top: 16, bottom: 16),
        ),
      ),
  );
}
);
}
}

const List<Color> gradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];