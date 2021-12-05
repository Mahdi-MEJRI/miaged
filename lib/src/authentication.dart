import 'package:flutter/material.dart';
import 'package:miaged/src/menu.dart';

import 'widgets.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication extends StatelessWidget {
  const Authentication({
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
  });

  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
      String displayFirstName,
    String bd,
    String adress,
    String cp,
    String town,
    String password,
    void Function(Exception e) error,
  ) registerAccount;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return Column(
          children: [
            Image.asset('assets/acceuil.jpg',
                height: 360,
                width: 500),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 8),
              child: StyledButton(
                onPressed: () {
                  startLoginFlow();
                },
                child: const Text('Connexion'),
              ),
            ),
          ],
        );
      case ApplicationLoginState.emailAddress:
        return EmailForm(
            callback: (email) => verifyEmail(
                email, (e) => _showErrorDialog(context, 'Email invalide', e)),
            cancel: () {
                cancelRegistration();
            },
        );
      case ApplicationLoginState.password:
        return PasswordForm(
          email: email!,
          login: (email, password) {
            signInWithEmailAndPassword(email, password,
                (e) => _showErrorDialog(context, 'Connexion échouée', e));
          },
          cancel: () {
            cancelRegistration();
          },
        );
      case ApplicationLoginState.register:
        return RegisterForm(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
            email,
            displayName,
              displayFirstName,
            bd,
            adress,
            cp,
            town,
            password,
          ) {
            registerAccount(
                email,
                displayName,
                displayFirstName,
                bd,
                adress,
                cp,
                town,
                password,
                (e) =>
                    _showErrorDialog(context, 'Création du compte échouée', e));
          },
        );
      case ApplicationLoginState.loggedIn:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 260, bottom: 0),
              child: StyledButton(
                onPressed: () {
                  signOut();
                },
                child: const Text('Se déconnecter'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 8),
              child: Container(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.height / 1.30,
                child: Menu(),
              ),
            ),

          ],
        );
      default:
        return Row(
          children: const [
            Text("Erreur interne ..."),
          ],
        );
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({
    required this.callback,
    required this.cancel,
  });
  final void Function(String email) callback;

  final void Function() cancel;

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/acceuil.jpg',
            height: 310,
            width: 500),
        const SizedBox(height: 25),
        const Header('Connexion avec adresse mail'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Entrer votre adresse email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre adresse email pour continuer';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: widget.cancel,
                            child: const Text('Annuler'),
                          ),
                          const SizedBox(width: 16),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                      child: StyledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            widget.callback(_controller.text);
                          }
                        },
                        child: const Text('Suivant'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    required this.registerAccount,
    required this.cancel,
    required this.email,
  });
  final String email;
  final void Function(String email, String displayName, String displayFirstName, String bd,
      String adress, String cp, String town, String password)
      registerAccount;
  final void Function() cancel;
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _displayFirstNameController = TextEditingController();
  final _displayBdController = TextEditingController();
  final _displayAdressController = TextEditingController();
  final _displayCpController = TextEditingController();
  final _displayTownController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header('Créer votre compte MIAGED'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Entrer votre adresse email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre adresse mail pour continuer';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _displayFirstNameController,
                    decoration: const InputDecoration(
                      hintText: 'Nom',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre nom';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _displayNameController,
                    decoration: const InputDecoration(
                      hintText: 'Prénom',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre prénom';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _displayBdController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      hintText: 'Date de naissance',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre date de naissance';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _displayAdressController,
                    decoration: const InputDecoration(
                      hintText: 'Adresse',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre adresse';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _displayCpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Code Postal',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre code postal';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _displayTownController,
                    decoration: const InputDecoration(
                      hintText: 'Ville',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre ville';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Mot de passe',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre mot de passe';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: widget.cancel,
                        child: const Text('Annuler'),
                      ),
                      const SizedBox(width: 16),
                      StyledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.registerAccount(
                              _emailController.text,
                              _displayNameController.text,
                              _displayFirstNameController.text,
                              _displayBdController.text,
                              _displayAdressController.text,
                              _displayCpController.text,
                              _displayTownController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: const Text('Enregistrer'),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    required this.login,
    required this.cancel,
    required this.email,

  });
  final String email;
  final void Function(String email, String password) login;

  final void Function() cancel;
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/acceuil.jpg',
            height: 260,
            width: 500),
        const SizedBox(height: 25),
        const Header('Se connecter'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Entrer votre adresse email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre adresse email pour continuer';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Mot de passe',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrer votre passe';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 82),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: widget.cancel,
                          child: const Text('Annuler'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StyledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: const Text('Se connecter'),
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                ),
                ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

