import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:miaged/src/profile.dart';
import 'package:miaged/src/vetements.dart';
import 'package:miaged/src/panier.dart';


class Menu extends StatefulWidget {
  Menu();
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  MenuState();
  FirebaseAuth auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      body: DefaultTabController(
        length: 3,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Scaffold(
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(bottom: 1),
                child: TabBar(
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.book), text: "Acheter",),
                    Tab(icon: Icon(Icons.shopping_cart), text: "Panier"),
                    Tab(icon: Icon(Icons.account_circle), text: "Profile"),
                  ],
                  labelColor: Color(0xff8c52ff),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Color(0xff8c52ff), width: 4.0),
                    insets: EdgeInsets.only(bottom: 44),
                  ),
                  unselectedLabelColor: Colors.grey,
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  Vetements(),
                  Panier(),
                  Profile(auth.currentUser!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
