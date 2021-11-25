import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salonhouse/src/preferencias_usuario/preferences_user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';

class Ususario_Provider {
  //
  final String _firebasetokken =
      'AIzaSyCFnPaSO6t4mTQNKU1sIJU5ZEkpGENseRc'; //setting/firebase/clave api web

  final _pref_shared =
      new PreferenciasUsuario(); //instancia para shared preferences

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final GoogleSignIn googleSignIn = GoogleSignIn();

//

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authdata = {
      'email': email,
      'password': password,
      'return_Secure_Tokken': true
    };
    //aqui la diferencia es el ul donde nos dirigimos para validar el usuario
    final Uri url_endpoint_auth = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebasetokken');

    final respuesta =
        await http.post(url_endpoint_auth, body: json.encode(authdata));

    Map<String, dynamic> decodeRespuesta = json.decode(respuesta.body);
    // print(decodeRespuesta); //aqui meustra que creamos la autenticacion correctamente
    //localId: uis  //idToken: token secion
    if (decodeRespuesta.containsKey('localId')) {
      //salvar el tokken en shared preferences
      _pref_shared.token = decodeRespuesta['localId'];
      print(decodeRespuesta);
      return {
        'ok': true,
        'token': decodeRespuesta['localId']
      }; //ruta json con el idtokken
    } else {
      //error ej email ya usado
      return {
        'ok': false,
        'mensaje': decodeRespuesta['error']['message']
      }; //ruta con el error json
      //

    }
  }

  Future<Map<String, dynamic>> nuevousuario(
      String email, String password) async {
    final authdata = {
      'email': email,
      'password': password,
      'return_Secure_Token': true
    };

    final Uri url_endpoint_auth = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebasetokken');

    final respuesta =
        await http.post(url_endpoint_auth, body: json.encode(authdata));

    Map<String, dynamic> decodeRespuesta = json.decode(respuesta.body);
    print(
        decodeRespuesta); //aqui meustra que creamos la autenticacion correctamente

    //localId: uis  //idToken: token secion

    if (decodeRespuesta.containsKey('localId')) {
//sobreescribir el tokken en sharen preferences
      _pref_shared.token = decodeRespuesta['localId'];

      return {
        'ok': true,
        'mensaje': decodeRespuesta['localId']
      }; //ruta json con el idtokken
    } else {
      //error ej email ya usado
      return {
        'ok': false,
        'mensaje': decodeRespuesta['error']['message']
      }; //ruta con el error json
      //

    }
  }

  Future<String> getuid2() async {
    final tokenResult = _auth.currentUser;
    final idToken = await tokenResult;
    final token = idToken!.uid.toString();

    if (token != null) {
      return token;
    } else {
      return "token no obtenido";
    }

//    final User? user = await _auth.currentUser;

    // final String uid = user!.uid;
  }

  Future<String> fechadeCreacionCuenta() async {
    //fiirebase retorna eos valores de tipo long

    //String fecha = await _auth.currentUser.metadata.creationTime;

    return ""; //esta es la ruta para acceder a datos directos en firebase
  }

//firebase auth
  /*
  Future getuid() async {
    final FirebaseUser user;

    try {
      // AuthResult result = await _auth.signInAnonymously(); //.currentUser();
      final pref = new PreferenciasUsuario();
      String tokkenlogin;
      if (pref.token != null) {
        // print(pref.token);
        tokkenlogin = pref.token;
        AuthResult result = await _auth.signInWithCustomToken(
            token: tokkenlogin); //.currentUser();

        // print(pref.token); //imprime el tokken cuando se obtiene
        user = result.user;
        return user.uid.toString();
      }

      // final uid = user.uid.toString();

      // Similarly we can get email as well
      //final uemail = user.email;
    } catch (e) {
      return null;
    }

    //print(uemail);
  }

*/
}
