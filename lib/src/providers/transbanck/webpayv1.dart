import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//no terminado  version vieja e inutil a la fecha 13/07/2021
class Webpagy_pagina_pagar extends StatefulWidget {
  // name({Key key}) : super(key: key);

  @override
  _Webpagy_pagina_pagarState createState() => _Webpagy_pagina_pagarState();
}

final url_webviwe_pagar = //_traerurl_tokken().toString();
    "https://webpay3gint.transbank.cl/webpayserver/initTransaction";

class _Webpagy_pagina_pagarState extends State<Webpagy_pagina_pagar> {
//en este ejemplo traemos el url en java scrip de node js y lo traemos para usar con flutter
//
  InAppWebViewController? webView_controler;

  final url_webview = //_traerurl_tokken();
      'https://webpay3gint.transbank.cl';

  @override
  Widget build(BuildContext context) {
    //
    //_traerurl_tokken();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('transbanck web pay'),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url_webviwe_pagar)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true, //recibe javascrip
              cacheEnabled: false,
            ),
            android: AndroidInAppWebViewOptions(
              thirdPartyCookiesEnabled: true,
            ),
          ),
          onWebViewCreated: (controller) {
            //

            webView_controler = controller; //abjo puse un '!'
            webView_controler!.addJavaScriptHandler(
              handlerName: 'Greenchanel',
              callback: (arg) {
                //aqui reguntamos en la lista , si esta lista es =1
                if (arg.length == 1) {
                  print('pago exitoso ');
                }
              },
            );
          },
        ),
      ),

      //   child: child,
    );
  }
}

Future<String> _traerurl_tokken() async {
  var url_return = 'https://webpay3gint.transbank.cl';
  var url_return2 = "http://www.comercio.cl/webpay/retorno";

  var url_test = 'https://webpay3gint.transbank.cl'; //integracion
  var url_production = 'https://webpay3g.transbank.cl';

  final authdata = {
    //enviamos la solicitud con lso datos de peticion http
    'Tbk-Api-Key-Id': '597055555532',
    'tbk-Api-Key-Secret':
        '579B532A7440BB0C9079DED94D31EA1615BACEB56610332264630D42D0A36B1C',
    'Content-Type': 'application/json',
  };
  //devolver lo   ue traer
  ////creamos el objeto de pago
  final data_order = {
    'buy_order': 'orden00122', //process['order'],
    'session_id': '0111', //process['order'], //order
    'amount': '50000', //process['amount'],
    'return_url': url_return,

    //devolver lo   ue traer
  };
  //

  //https://webpay3gint.transbank.cl/rswebpaytransaction/api/webpay/v1.0/transactions
  final Uri url_transaccion = Uri.parse(
      '${url_test}/rswebpaytransaction/api/webpay/v1.0/transactions'); //query

  final Uri url_transaccionv2 = Uri.parse(
      "https://webpay3gint.transbank.cl/rswebpaytransaction/api/webpay/v1.0/transactions");
  //POST-crear transacion
  final response2 = await http.post(
    url_transaccionv2,
    headers: authdata,
    body: data_order,
  ); //envia todo el cuarpo model
  //body: authdata,headers: data_order); //envia todo el cuarpo model
  print("hobtener tokkens:!!!!!!!!!!");
  final decodedata = json.decode(response2.body); //respuesta
  print(decodedata);
  print("here!!!!!!!!!!!!!!!!!!!!!!!!!!!");

  Map<String, dynamic> decodeRespuesta = json.decode(response2.body);
  print(decodeRespuesta);

  if (decodeRespuesta.containsKey("token")) {
    //print(decodeRespuesta['token']);
    //print(decodeRespuesta['url']);
    //salvar el tokken en shared preferences

    // _pref_shared.token = decodeRespuesta['localId'];
    // print(decodeRespuesta);
    //final j= {'ok': true,'token': decodeRespuesta['localId']};

    return decodeRespuesta['url'];
  } //ruta json con el idtokken
  else {
    //error ej email ya usado
    // final json2=  {'ok': false,'mensaje': decodeRespuesta['error']['message']}; //ruta con el error json
    return 'error token no obtnido ';
    //

  }
}

/*{
    "Tbk-Api-Key-Id": "597055555532",
    "Tbk-Api-Key-Secret":
        "579B532A7440BB0C9079DED94D31EA1615BACEB56610332264630D42D0A36B1C",
    "Content-Type": "application/json",
  } */
