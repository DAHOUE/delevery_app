import 'package:my_flutter_delivery_app/Models/Order.dart';
import 'database.dart';
import 'detailCommande.dart';
import 'package:flutter/material.dart';

class CommandeLivrePage extends StatefulWidget {
  @override
  _CommandeLivrePageState createState() => _CommandeLivrePageState();
}

class _CommandeLivrePageState extends State<CommandeLivrePage> {
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
        if (element.orderStat != "0") {
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
        appBar: AppBar(
          title: Text("Liste des Commandes livrées"),
        ),
        body: orderList.length != 0
            ? ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (BuildContext context, int i) {
            String id = orderList[i].id.toString();
            return Card (
              elevation: 3.0,
              child: Row (
                children: <Widget> [
                  SizedBox (
                    width: 5.0,
                  ),
                  CircleAvatar (
                    child: Icon(Icons.shopping_cart),
                    radius: 30.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                      child: ListTile(
                        title: Text (
                          orderList[i].nomProduit,
                          style: TextStyle (fontSize: 14),
                        ),
                        subtitle: Text (orderList[i].nomPrenoms),
                        trailing: PopupMenuButton<String>( padding: EdgeInsets.zero,
                            onSelected: (value) {
                          if (<String>["Détails", "Envoyer"]
                              .contains(value)) {
                            switch (value) {
                              case "Détails":
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute( builder: (context) =>
                                          DetailCommande(
                                              id, false)));
                                }
                                break;
                            }
                          }
                          },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                  value: 'Détails',
                                  child: ListTile(
                                      leading: Icon(
                                          Icons.arrow_forward_ios),
                                      title: Text('Détails de la Commande'))),
                            ]
                        )
                    )
                ),
              ],
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
              Text("Vous n'avez aucune commande",
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