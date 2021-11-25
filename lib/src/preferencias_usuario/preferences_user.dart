//este codigo ya esta prehecho para que solo podamos acceder a los datos que nos interesa

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();
  SharedPreferences? _prefs;

//inicia la busqueda de preferncas
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del tokken auth user
  String get token {
    return _prefs?.getString('token') ?? '';
  }

  set token(String value) {
    _prefs?.setString('token', value);
  }

  String get token_notifi {
    return _prefs?.getString('token_notify') ?? '';
  }

  set token_notifi(String value) {
    _prefs?.setString('token_notify', value);
  }

  // GET y SET de la última página
  String get ultimaPagina {
    return _prefs?.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs?.setString('ultimaPagina', value);
  }

  //nombre y foto
  String get nombre {
    return _prefs?.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs?.setString('nombre', value);
  }

  String get foto {
    return _prefs?.getString('foto') ?? '';
  }

  set foto(String value) {
    _prefs?.setString('foto', value);
  }

  String get telefono {
    return _prefs?.getString('telefono') ?? '';
  }

  set telefono(String value) {
    _prefs?.setString('telefono', value);
  }

  String get direccion {
    return _prefs?.getString('direccion') ?? '';
  }

  set direccion(String value) {
    _prefs?.setString('direccion', value);
  }

  //maps
  double get latitud {
    return _prefs?.getDouble('latitud') ?? 0.0;
  }

  set latitud(double value) {
    _prefs?.setDouble('latitud', value);
  }

  double get longitud {
    return _prefs?.getDouble('longitud') ?? 0.0;
  }

  set longitud(double value) {
    _prefs?.setDouble('longitud', value);
  }

//para la notifi del local
  String get notifi_local_abierto {
    return _prefs?.getString('localabierto') ?? '';
  }

  set notifi_local_abierto(String value) {
    _prefs?.setString('localabierto', value);
  }

  //local abierto
  bool get atendiendo {
    return _prefs?.getBool('atendiendo') ?? false;
  }

  set atendiendo(bool value) {
    _prefs?.setBool('atendiend', value);
  }
}
