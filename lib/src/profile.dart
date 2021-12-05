import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Profile extends StatelessWidget {
  final User user;
  Profile(this.user);

  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _displayFirstNameController = TextEditingController();
  final _displayBdController = TextEditingController();
  final _displayAdressController = TextEditingController();
  final _displayCpController = TextEditingController();
  final _displayTownController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('utilisateurs');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Erreur");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Erreur");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            padding: EdgeInsets.only(
                left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Text(
                    "Profile" ,
                    style: TextStyle(fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  buildTextField("Login", data['login'], false,  true, false, _emailController),
                  buildTextField("Nom", data['nom'], false, false, false, _displayNameController),
                  buildTextField("Prénom", data['prenom'],  false, false, false, _displayFirstNameController),
                  buildTextField("Anniversaire", data['bd'], false, false, false,  _displayBdController),
                  buildTextField("Adresse", data['adresse'], false,  false, false, _displayAdressController),
                  buildTextField("Ville", data['ville'], false,  false, false, _displayTownController),
                  buildTextField("Code Postal", data['cp'], false, false, true, _displayCpController),
                  buildTextField("Mot de passe", "**********", true,  false, false, _passwordController),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center,
                    children: [
                      RaisedButton(
                        onPressed: () {

                          String password;
                          if (_passwordController.text.length >= 6) {
                            password = _passwordController.text;
                            user.updatePassword(_passwordController.text);
                          }
                          else password = data["mdp"];

                          String email;
                          if (_emailController.text != "") email = _emailController.text;
                          else email = data["login"];

                          String nom;
                          if (_displayNameController.text != "") nom = _displayNameController.text;
                          else nom = data["nom"];

                          String prenom;
                          if (_displayFirstNameController.text != "") prenom = _displayFirstNameController.text;
                          else prenom = data["prenom"];

                          String adresse;
                          if (_displayAdressController.text != "") adresse = _displayAdressController.text;
                          else adresse = data["adresse"];

                          String ville;
                          if (_displayTownController.text != "") ville = _displayTownController.text;
                          else ville = data["ville"];

                          String cp;
                          if (_displayCpController.text != "") cp = _displayCpController.text;
                          else cp = data["cp"];

                          String bd;
                          if (_displayBdController.text != "") bd = _displayBdController.text;
                          else bd = data["bd"];

                          users.doc(user.uid).set({"mdp": password, 'login': email, 'prenom' : prenom, 'nom': nom,
                            'bd' : bd, 'adresse' : adresse, 'ville' : ville, 'cp' : cp});
                        },

                        color: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(
                            horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20)),
                        child: Text(
                          "Enregistrer les modifications",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );

        }
        return Text("Chargement ...");
      },
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, bool isMail, bool isCp, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        keyboardType: isCp ? TextInputType.number : TextInputType.text,
        readOnly: isMail ? true : false,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),
      ),
    );
  }
}
