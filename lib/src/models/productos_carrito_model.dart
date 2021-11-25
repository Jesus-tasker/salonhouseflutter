// To parse this JSON data, do
//
//     final productoscarrito = productoscarritoFromJson(jsonString);

import 'dart:convert';

Productoscarrito productoscarritoFromJson(String str) =>
    Productoscarrito.fromJson(json.decode(str));

String productoscarritoToJson(Productoscarrito data) =>
    json.encode(data.toJson());

class Productoscarrito {
  Productoscarrito({
    required this.categoriaProducto,
    required this.codigo,
    required this.fotoString,
    required this.nombre,
    required this.precio,
    required this.precio2Int,
    required this.disponible,
    required this.timestampString,
  });

  String categoriaProducto;
  int codigo;
  String fotoString;
  String nombre;
  String precio;
  int precio2Int;
  bool disponible;
  String timestampString;

  factory Productoscarrito.fromJson(Map<String, dynamic> json) =>
      Productoscarrito(
        categoriaProducto: json["categoria_producto"],
        codigo: json["codigo"],
        fotoString: json["foto_string"],
        nombre: json["nombre"],
        precio: json["precio"],
        precio2Int: json["precio2_int"],
        disponible: json["disponible"],
        timestampString: json["timestamp_string"],
      );

  Map<String, dynamic> toJson() => {
        "categoria_producto": categoriaProducto,
        "codigo": codigo,
        "foto_string": fotoString,
        "nombre": nombre,
        "precio": precio,
        "precio2_int": precio2Int,
        "disponible": disponible,
        "timestamp_string": timestampString,
      };

  getposterimage() {
    //aqui haremmos la logica para caargar la imagen

    if (fotoString == null) {
      return 'https://image.freepik.com/free-vector/loading-icon_167801-436.jpg'; //img cargando traida de google

    } else {
      //https://developers.themoviedb.org/3/getting-started/images
      return '$fotoString'; //cargamos solo el url del poster path //imagen de promcion

    }
  }
}
