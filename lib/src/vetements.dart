import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:miaged/src/detail.dart';

class Vetements extends StatefulWidget {
  Vetements();
  @override
  VetementsState createState() => VetementsState();
}

class VetementsState extends State<Vetements> {
  VetementsState();

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      body: DefaultTabController(
        length: 4,
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
                    Tab(text: "Tous",),
                    Tab(text: "Haut"),
                    Tab(text: "Bas"),
                    Tab(text: "Chaussures"),
                  ],
                  labelColor: Color(0xff8c52ff),
                  indicator: UnderlineTabIndicator(
                    insets: EdgeInsets.only(bottom: 4),
                  ),
                  unselectedLabelColor: Colors.grey,
                ),
              ),

      body: TabBarView(
          children: <Widget>[
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('vetements').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.count(
            crossAxisCount: 2,
              children: snapshot.data!.docs.map((document) {
                return Column(
                    children: [
                 Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.height / 4.4,
                        child : GestureDetector(onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail(
                            titre: document['titre'],
                            prix: document['prix'],
                            image: document['image'],
                            taille: document['taille'],
                            marque: document['marque'],
                          ) ));
                        },
                            child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: GridTile(
                                  child:Image.network(document['image']),
                                  footer: GridTileBar(
                       title: Text(document['titre'] + "\nTaille : "
                    + document['taille'] + "\nPrix : " + document['prix'].toString() + "€"),
                                    backgroundColor: Colors.black87,
                                  ),
                                )
                            )
                          ),
                        ),
                 ],
                );
              }).toList(),
            scrollDirection: Axis.vertical,
            );
          }),

            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('vetements').where('categ', isEqualTo: 'haut').snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    children: snapshot.data!.docs.map((document) {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: MediaQuery.of(context).size.height / 4.4,
                            child : GestureDetector(onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail(
                                titre: document['titre'],
                                prix: document['prix'],
                                image: document['image'],
                                taille: document['taille'],
                                marque: document['marque'],
                              ) ));
                            },
                                child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: GridTile(
                                      child:Image.network(document['image']),
                                      footer: GridTileBar(
                                        title: Text(document['titre'] + "\nTaille : "
                                            + document['taille'] + "\nPrix : " + document['prix'].toString() + "€"),
                                        backgroundColor: Colors.black87,
                                      ),
                                    )
                                )
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    scrollDirection: Axis.vertical,
                  );
                }),

            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('vetements').where('categ', isEqualTo: 'bas').snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    children: snapshot.data!.docs.map((document) {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: MediaQuery.of(context).size.height / 4.4,
                            child : GestureDetector(onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail(
                                titre: document['titre'],
                                prix: document['prix'],
                                image: document['image'],
                                taille: document['taille'],
                                marque: document['marque'],
                              ) ));
                            },
                                child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: GridTile(
                                      child:Image.network(document['image']),
                                      footer: GridTileBar(
                                        title: Text(document['titre'] + "\nTaille : "
                                            + document['taille'] + "\nPrix : " + document['prix'].toString() + "€"),
                                        backgroundColor: Colors.black87,
                                      ),
                                    )
                                )
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    scrollDirection: Axis.vertical,
                  );
                }),

            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('vetements').where('categ', isEqualTo: 'chaussures').snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    children: snapshot.data!.docs.map((document) {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: MediaQuery.of(context).size.height / 4.4,
                            child : GestureDetector(onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail(
                                titre: document['titre'],
                                prix: document['prix'],
                                image: document['image'],
                                taille: document['taille'],
                                marque: document['marque'],
                              ) ));
                            },
                                child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: GridTile(
                                      child:Image.network(document['image']),
                                      footer: GridTileBar(
                                        title: Text(document['titre'] + "\nTaille : "
                                            + document['taille'] + "\nPrix : " + document['prix'].toString() + "€"),
                                        backgroundColor: Colors.black87,
                                      ),
                                    )
                                )
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    scrollDirection: Axis.vertical,
                  );
                }),

    ],

    ),
      ),
    ],
    ),
        ),
    );
  }

}
