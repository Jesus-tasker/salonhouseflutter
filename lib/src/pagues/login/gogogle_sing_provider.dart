import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInProvider extends ChangeNotifier {
  final googlesingin = GoogleSignIn();
  GoogleSignInAccount? _user; //autenticacion - creo qeu es la informacion
  GoogleSignInAccount get user =>
      _user!; //autenticacion - creo qeu es la informacion

  Future googlelogin() async {
    final googleuser = await googlesingin
        .signIn(); //pop up cuando aparecen las opcinoes de cuentas
    if (googleuser == null) return;
    _user = googleuser; //si el usuario existe

    final googleAuth = await googleuser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners(); //update
  }

  Future longout_cerrar() async {
    await googlesingin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

/*
class AutenticarFoofle {

  GoogleSignIn _googleSignIn = (
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

}*/
