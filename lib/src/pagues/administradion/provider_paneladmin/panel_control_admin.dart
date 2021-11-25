import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Panel_control_admin {
  Future<String> confirmar_estadodepago(
      Map<String, String> dataconfirmar, String buyOrder) async {
    //iniciamos peticion
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('http://salonhousev2.herokuapp.com/confirmarpago/asdf'));
    request.body = jsonEncode(dataconfirmar);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("200");
      print(await response.stream.bytesToString()); //recibo AUTH
      var pagoautorizado = await response.stream.bytesToString();

      await _status_admin_autorizado(buyOrder);

      // .update({'id_Pagocomletado': '2'}).then((value) => print( "actualizado pago2")); //1. pendiente,2pagado,3preparando,enviando
      //.where("buyOrder",isEqualTo: buyOrder); //.update({'company': 'Stokes and Sons'});

      return pagoautorizado;
    } else {
      print(response.reasonPhrase);
      return ("Sin pagar ");
    }
  }

  Future _status_admin_autorizado(String buyorder) async {
    var busqueda3 = FirebaseFirestore.instance
        .collection('Orders_admin')
        .doc("peluqueuria")
        .collection('general')
        .doc(buyorder);
    await busqueda3.update({'status': 'AUTORIZED'}).then((value) => () {
          print("actualizado en el panel adminsitrativo");
        }); //1. pendiente,2pagado,3preparando,enviando
  }
}
