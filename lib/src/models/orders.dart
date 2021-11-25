// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));

String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
  Orders({
    required this.idPagocomletado,
    required this.buyOrder,
    required this.sessionId,
    required this.timestamp,
    required this.status,
    required this.keyBusqueda,
    required this.keyUid,
    required this.notifiuidCliente,
    required this.fotografia,
    required this.nombreCliente,
    required this.direccion,
    required this.totalString,
    required this.telefono,
    required this.fechaReservacion,
    required this.fechaServicios,
    required this.horaServicios,
    required this.totalInt,
    required this.latitudCliente,
    required this.longitudCliente,
    required this.nombreworker,
    required this.fotoworker,
    required this.keyworker,
    required this.productoscarrito_order,
  });

  int idPagocomletado;
  String buyOrder;
  String sessionId;
  String timestamp;
  String status;
  String keyBusqueda;
  String keyUid;
  String notifiuidCliente;
  String fotografia;
  String nombreCliente;
  String direccion;
  String totalString;
  String telefono;
  String fechaReservacion;
  String fechaServicios;
  String horaServicios;
  int totalInt;
  double latitudCliente;
  double longitudCliente;
//
  String nombreworker;
  String fotoworker;
  String keyworker;
//
  List<Productoscarrito_order> productoscarrito_order;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        idPagocomletado: json["id_pagocomletado"],
        buyOrder: json["buyOrder"],
        sessionId: json["sessionId"],
        timestamp: json["timestamp"],
        status: json["status"],
        keyBusqueda: json["key_busqueda"],
        keyUid: json["key_uid"],
        notifiuidCliente: json["notifiuid_cliente"],
        fotografia: json["fotografia"],
        nombreCliente: json["nombre_cliente"],
        direccion: json["direccion"],
        totalString: json["total_string"],
        telefono: json["telefono"],
        fechaReservacion: json["fecha_reservacion"],
        fechaServicios: json["fecha_servicios"],
        horaServicios: json["hora_servicios"],
        totalInt: json["total_int"],
        latitudCliente: json["latitud_cliente"],
        longitudCliente: json["longitud_cliente"],
        nombreworker: json["nombreworker"],
        fotoworker: json["fotoworker"],
        keyworker: json["keyworker"],
        productoscarrito_order: List<Productoscarrito_order>.from(
            json["Productoscarrito"]
                .map((x) => Productoscarrito_order.fromJson(x))),
      );
  factory Orders.fromDocument(DocumentSnapshot document_snap) => Orders(
        idPagocomletado: document_snap["id_pagocomletado"],
        buyOrder: document_snap["buyOrder"],
        sessionId: document_snap["sessionId"],
        timestamp: document_snap["timestamp"],
        status: document_snap["status"],
        keyBusqueda: document_snap["key_busqueda"],
        keyUid: document_snap["key_uid"],
        notifiuidCliente: document_snap["notifiuid_cliente"],
        fotografia: document_snap["fotografia"],
        nombreCliente: document_snap["nombre_cliente"],
        direccion: document_snap["direccion"],
        totalString: document_snap["total_string"],
        telefono: document_snap["telefono"],
        fechaReservacion: document_snap["fecha_reservacion"],
        fechaServicios: document_snap["fecha_servicios"],
        horaServicios: document_snap["hora_servicios"],
        totalInt: document_snap["total_int"],
        latitudCliente: document_snap["latitud_cliente"],
        longitudCliente: document_snap["longitud_cliente"],
        nombreworker: "nombreworker",
        fotoworker: "fotoworker",
        keyworker: "keyworker",
        productoscarrito_order: List<Productoscarrito_order>.from(
            document_snap["Productoscarrito"]
                .map((x) => Productoscarrito_order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_pagocomletado": idPagocomletado,
        "buyOrder": buyOrder,
        "sessionId": sessionId,
        "timestamp": timestamp,
        "status": status,
        "key_busqueda": keyBusqueda,
        "key_uid": keyUid,
        "notifiuid_cliente": notifiuidCliente,
        "fotografia": fotografia,
        "nombre_cliente": nombreCliente,
        "direccion": direccion,
        "total_string": totalString,
        "telefono": telefono,
        "fecha_reservacion": fechaReservacion,
        "fecha_servicios": fechaServicios,
        "hora_servicios": horaServicios,
        "total_int": totalInt,
        "latitud_cliente": latitudCliente,
        "longitud_cliente": longitudCliente,
        "nombreworker": nombreworker,
        "fotoworker": fotoworker,
        "keyworker": keyworker,
        "Productoscarrito":
            List<dynamic>.from(productoscarrito_order.map((x) => x.toJson())),
      };
}

class Productoscarrito_order {
  Productoscarrito_order({
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
  String codigo;
  String fotoString;
  String nombre;
  String precio;
  int precio2Int;
  bool disponible;
  String timestampString;

  factory Productoscarrito_order.fromJson(Map<String, dynamic> json) =>
      Productoscarrito_order(
        categoriaProducto: json["categoria_producto"],
        codigo: json["codigo"],
        fotoString: json["foto_string"],
        nombre: json["nombre"],
        precio: json["precio"],
        precio2Int: json["precio2_int"],
        disponible: json["disponible"],
        timestampString: json["timestamp_string"],
      );
  getposterimage() {
    //aqui haremmos la logica para caargar la imagen

    if (fotoString == null) {
      return 'https://image.freepik.com/free-vector/loading-icon_167801-436.jpg'; //img cargando traida de google

    } else {
      //https://developers.themoviedb.org/3/getting-started/images
      return fotoString; //cargamos solo el url del poster path //imagen de promcion

    }
  }

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
}

/*{
 "id_pagocomletado":1, 
   "buyOrder": "numero1111",
"sessionId": "11111",
    "timestamp": "timestamp",
    "status": "pendiente",
     "key_busqueda":"key_busqueda",
     "key_uid":"key_uid",
    "notifiuid_cliente":"notifiuid_cliente",
    "fotografia":"fotografia",
    "nombre_cliente":"nombre_cliente",
    "direccion":"direccion",
    "total_string":"total_stringddd" ,
    "telefono":"telefono",
    "fecha_reservacion":"fecha_reservacion",
    "fecha_servicios":"fecha_servicios",
    "hora_servicios":"hora_servicios",
    "total_int":2000,
    "latitud_cliente":"17.89",
    "longitud_cliente":"13.79",
    "nombreworker": "jesus",
    "fotoworker": "timestamp",
     "keyworker": "a",
  
      "Productoscarrito_order":[{
         "categoria_producto": "categoriaProducto",
        "codigo": "codigo",
        "foto_string": "fotoString",
        "nombre": "nombre",
        "precio": "precio",
        "precio2_int": 2000,
        "disponible": true,
        "timestamp_string": "timestampString"
    }] */