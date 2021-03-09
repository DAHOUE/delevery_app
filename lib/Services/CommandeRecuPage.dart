import 'package:my_flutter_delivery_app/Models/Order.dart';
import 'database.dart';
import 'detailCommande.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommandeRecuPage extends StatefulWidget {
  String idCommande;
  @override
  _CommandeRecuPageState createState() =>  _CommandeRecuPageState();
}

class _CommandeRecuPageState extends State<CommandeRecuPage> {
  DatabaseProvider db = new DatabaseProvider();
  List<Order> orderList = new List();

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  loadData() async {
    List<Order> tmpOrder = new List();
    tmpOrder = (await db.getAllOrder()).cast<Order>();
    if (tmpOrder != null) {
      tmpOrder.forEach((element) {
        if (element.orderStat == "0") {
          setState(() {
            orderList.add(element);
          }
          );
        }
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar (
          title: Text("Liste des Livraisons Reçues"),
        ),
        body: orderList.length != 0
            ? ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (BuildContext context, int i) {
            String id = orderList[i].id.toString();
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailCommande(id, true)));
                },
              child: Card(
                elevation: 3.0,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 5.0,
                    ),
                    CircleAvatar(
                      child: Icon(Icons.shopping_cart),
                      radius: 30.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                        child: ListTile(
                          title: Text(
                            orderList[i].nomProduit,
                            style: TextStyle(fontSize: 14),
                          ),
                          subtitle: Text(orderList[i].nomProduit),
                        )),
                  ],
                ),
              ),
            );
            },
        )
            : showNoOrder());
  }

  Widget showNoOrder() {
    return Center(
        child: Container(
        height: double.maxFinite,
        width: double.infinity,
        child: Center(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
        image:
        DecorationImage(image: AssetImage("images/box.png"))),
    ),
    Padding(padding: EdgeInsets.only(top: 20)),
          Text(
            "Vous n'avez aucune commande",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontFamily: "Roboto_light"),
          )
        ],
        ),
        ),
        ),
    );
  }
}