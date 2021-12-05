import 'package:flutter/material.dart';

import 'package:miaged/main.dart';


class Panier extends StatefulWidget {
  Panier();

  @override
  PanierState createState() => PanierState();
}

class PanierState extends State<Panier> {
  PanierState();

  Widget build(BuildContext context) {
    return Scaffold(
    body: ValueListenableBuilder(
        valueListenable: itemsNotifier,
        builder: (context, items, _) {
          List list = itemsNotifier.value;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Image.network(list[index][1].toString(), height: 100),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 30),
                        child: Text(list[index][0].toString() + "\nTaille : " + list[index][3].toString()
                            + "\nPrix : " + list[index][2].toString() + "€"),
                      ),
                    ],
                  ),
                  trailing : FloatingActionButton(
                    onPressed: () {
                      double _tmpsum = sum;
                      _tmpsum -= itemsNotifier.value[index][2];
                      sum = _tmpsum;
                  List _tmpList = itemsNotifier.value;
                  _tmpList.removeAt(index);
                  itemsNotifier.value = _tmpList;
                  setState(() {});
                },
                child: Icon(
                Icons.remove_shopping_cart,
                size: 30,
                ),
                ),
                );
              }
          );
        }

    ),
      bottomSheet:
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 150),
              child: Text("Total : " + sum.abs().toStringAsFixed(2),
                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),),
      ),
    );
  }


}