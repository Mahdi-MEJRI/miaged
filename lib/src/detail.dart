import 'package:flutter/material.dart';
import 'package:miaged/main.dart';

class Detail extends StatelessWidget {
  final String titre;
  final double prix;
  final String image;
  final String taille;
  final String marque;


  Detail({required this.titre, required this.prix, required this.image, required this.taille, required this.marque});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titre),
      ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              height: 400,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(image),
              ),
            ),
           Text(
              'Prix : \€${prix}',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Marque : ${marque}',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Taille : ${taille}',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            List _tmpList = itemsNotifier.value;
            List list = [titre, image, prix, taille];
            _tmpList.add(list);
            itemsNotifier.value = _tmpList;
            sum += prix;
          },
          child: Icon(
            Icons.add_shopping_cart,
            size: 30,
          ),
        ),
      );
  }
}