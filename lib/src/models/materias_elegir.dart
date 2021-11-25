// To parse this JSON data, do
//
//  final materias = materiasFromJson(jsonString);

import 'dart:convert';

Materias materiasFromJson(String str) => Materias.fromJson(json.decode(str));

String materiasToJson(Materias data) => json.encode(data.toJson());

class Materias {
  Materias({
    required this.idMaterias,
    required this.materia,
    required this.descripcion,
    required this.duracion,
    required this.valor,
    required this.disponible,
    required this.fotoUrlLogo,
    required this.fotoUrlFondo,
    required this.color,
  });

  String idMaterias;
  String materia;
  String descripcion;
  String duracion;
  int valor;
  bool disponible;
  String fotoUrlLogo;
  String fotoUrlFondo;
  String color;

  factory Materias.fromJson(Map<String, dynamic> json) => Materias(
        idMaterias: json["id_materias"],
        materia: json["materia"],
        descripcion: json["descripcion"],
        duracion: json["duracion"],
        valor: json["valor "],
        disponible: json["disponible"],
        fotoUrlLogo: json["foto_url_logo"],
        fotoUrlFondo: json["foto_url_fondo"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id_materias": idMaterias,
        "materia": materia,
        "descripcion": descripcion,
        "duracion": duracion,
        "valor ": valor,
        "disponible": disponible,
        "foto_url_logo": fotoUrlLogo,
        "foto_url_fondo": fotoUrlFondo,
        "color": color,
      };

  getposterimage() {
    //aqui haremmos la logica para caargar la imagen

    if (fotoUrlFondo == null) {
      return 'https://image.freepik.com/free-vector/loading-icon_167801-436.jpg'; //img cargando traida de google

    } else {
      //https://developers.themoviedb.org/3/getting-started/images
      return '$fotoUrlFondo'; //cargamos solo el url del poster path //imagen de promcion

    }
  }

  getbackgroundimage() {
    //obtenemos solo la imagen
    //aqui haremmos la logica para caargar la imagen

    if (fotoUrlLogo == null) {
      return 'https://image.freepik.com/free-vector/loading-icon_167801-436.jpg'; //img cargando traida de google

    } else {
      //backdropPath
      //https://developers.themoviedb.org/3/getting-started/images
      return '$fotoUrlLogo'; //cargamos solo el url del poster path //imagen de promcion

    }
  }
}
