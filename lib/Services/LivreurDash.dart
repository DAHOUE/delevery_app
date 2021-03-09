import 'CommandeLivrePage.dart';
import 'CommandeRecuPage.dart';
import 'package:flutter/material.dart';

class LivreurDash extends StatefulWidget {
  @override
  _LivreurDashState createState() => _LivreurDashState();
}

class _LivreurDashState extends State<LivreurDash> {
  int correntIndex = 0;
  List<Widget> children = [
    CommandeRecuPage(),
    CommandeLivrePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[correntIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: correntIndex,
          onTap: onTabTap,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.local_shipping), title: Text("Reçu")),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle), title: Text('Livrée')),
          ]),
    );
  }

  void onTabTap(int index) {
    setState(() {
      correntIndex = index;
    });
  }
}