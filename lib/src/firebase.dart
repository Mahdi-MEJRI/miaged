import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> userSetup(String email, String displayName, String firstName, String bd, String adresse, String ville, String cp, String uid, String password) async {
  CollectionReference users = FirebaseFirestore.instance.collection('utilisateurs');

  users.doc(uid).set({"mdp": password, 'login': email, 'prenom' : firstName, 'nom': displayName,
              'bd' : bd, 'adresse' : adresse, 'ville' : ville, 'cp' : cp});
  return;
}



