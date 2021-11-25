// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    required this.keyBusqueda,
    required this.keyUsuario,
    required this.notifiUid,
    required this.calificaion,
    required this.cargo,
    required this.fotodePerfilUri,
    required this.direccion,
    required this.latitud,
    required this.longitud,
    required this.teleonoUsuario,
    required this.usuarioNombre,
  });

  String keyBusqueda;
  String keyUsuario;
  String notifiUid;
  int calificaion;
  String cargo;
  String fotodePerfilUri;
  String direccion;
  double latitud;
  double longitud;
  String teleonoUsuario;
  String usuarioNombre;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        keyBusqueda: json["key_busqueda"],
        keyUsuario: json["key_usuario"],
        notifiUid: json["notifi_uid"],
        calificaion: json["calificaion"],
        cargo: json["cargo"],
        fotodePerfilUri: json["fotodePerfilURI"],
        direccion: json["direccion"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        teleonoUsuario: json["teleono_usuario"],
        usuarioNombre: json["usuario_nombre"],
      );

  factory Usuario.fromdocument(DocumentSnapshot json) => Usuario(
        keyBusqueda: json["key_busqueda"],
        keyUsuario: json["key_usuario"],
        notifiUid: json["notifi_uid"],
        calificaion: json["calificaion"],
        cargo: json["cargo"],
        fotodePerfilUri: json["fotodePerfilURI"],
        direccion: json["direccion"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        teleonoUsuario: json["teleono_usuario"],
        usuarioNombre: json["usuario_nombre"],
      );

  get id => null;

  Map<String, dynamic> toJson() => {
        "key_busqueda": keyBusqueda,
        "key_usuario": keyUsuario,
        "notifi_uid": notifiUid,
        "calificaion": calificaion,
        "cargo": cargo,
        "fotodePerfilURI": fotodePerfilUri,
        "direccion": direccion,
        "latitud": latitud,
        "longitud": longitud,
        "teleono_usuario": teleonoUsuario,
        "usuario_nombre": usuarioNombre,
      };

  factory Usuario.fromDocument(DocumentSnapshot json) => Usuario(
        keyBusqueda: json["key_busqueda"],
        keyUsuario: json["key_usuario"],
        notifiUid: json["notifi_uid"],
        calificaion: json["calificaion"],
        cargo: json["cargo"],
        fotodePerfilUri: json["fotodePerfilURI"],
        direccion: json["direccion"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        teleonoUsuario: json["teleono_usuario"],
        usuarioNombre: json["usuario_nombre"],
      );
}
