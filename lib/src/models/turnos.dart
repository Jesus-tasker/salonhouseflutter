// To parse this JSON data, do
//
//     final turno = turnoFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Turno turnoFromJson(String str) => Turno.fromJson(json.decode(str));

String turnoToJson(Turno data) => json.encode(data.toJson());

class Turno {
  Turno({
    required this.timestamp,
    required this.uid,
    required this.fotoString,
    required this.nombre,
    required this.tel,
    required this.profesion,
    required this.disponible,
    required this.notifi,
  });

  String timestamp;
  String uid;
  String fotoString;
  String nombre;
  String tel;
  String profesion;
  String notifi;
  bool disponible;

  factory Turno.fromJson(Map<String, dynamic> json) => Turno(
        timestamp: json["timestamp"],
        uid: json["uid"],
        fotoString: json["foto_string"],
        nombre: json["nombre"],
        tel: json["tel"],
        profesion: json["profesion"],
        disponible: json["disponible"],
        notifi: json[" notifi"],
      );
  factory Turno.fromdocument(DocumentSnapshot json) => Turno(
        timestamp: json["timestamp"],
        uid: json["uid"],
        fotoString: json["foto_string"],
        nombre: json["nombre"],
        tel: json["tel"],
        profesion: json["profesion"],
        disponible: json["disponible"],
        notifi: json[" notifi"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "uid": uid,
        "foto_string": fotoString,
        "nombre": nombre,
        "tel": tel,
        "profesion": profesion,
        "disponible": disponible,
        " notifi": notifi,
      };
}
