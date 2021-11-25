//import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/*
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:transbank1/model_transbanck1.dart';
import 'package:transbank1/webpay_pagina.dart';*/

import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    show
        AndroidInAppWebViewOptions,
        InAppWebView,
        InAppWebViewController,
        InAppWebViewGroupOptions,
        InAppWebViewInitialData,
        InAppWebViewOptions;
import 'package:salonhouse/src/models/model_transbanck1.dart';
import 'package:salonhouse/src/models/orders.dart';
import 'package:salonhouse/src/models/productos_carrito_model.dart';
import 'package:salonhouse/src/providers/login/provider_perfilusuario.dart';
import 'package:salonhouse/src/utils/utils_textos.dart';

int total_int_p = 0;

Orders ordendecompra_p = new Orders(
    idPagocomletado: 0,
    timestamp: "timestamp",
    buyOrder: 'sdf',
    sessionId: 'asdf',
    keyBusqueda: "keyBusqueda",
    status: 'pendiente',
    keyUid: "keyUid",
    notifiuidCliente: "notifiuidCliente",
    fotografia: "fotografia",
    nombreCliente: "nombreCliente",
    direccion: "direccion",
    totalString: "totalString",
    telefono: "telefono",
    fechaReservacion: "fechaReservacion",
    fechaServicios: "fechaServicios",
    horaServicios: "horaServicios",
    totalInt: 2000,
    latitudCliente: 0,
    longitudCliente: 0,
    nombreworker: "nombreworker", //
    fotoworker: "fotoworker",
    keyworker: "keyworker",
    productoscarrito_order: []);

class Webpay_pagarV4 extends StatefulWidget {
  final Orders ordendecompra_w;

  final int total;

  Webpay_pagarV4(this.ordendecompra_w, this.total);

  // name({Key key}) : super(key: key);

  @override
  _Webpay_pagarV4State createState() => _Webpay_pagarV4State();
  // Webpay_pagarV4(this._lista, this._categoria_seleccionada_carrito);
}

String url_api = "";
String token_api = "";
var html_data;

class _Webpay_pagarV4State extends State<Webpay_pagarV4> {
  @override
  Widget build(BuildContext context) {
    print("enter pagarwebpay");
    total_int_p = widget.total;
    ordendecompra_p = widget.ordendecompra_w;
    print(ordendecompra_p.buyOrder.toString());

    print(total_int_p);
    print("lista");

    ///  enviardatosyobtenerurl();
    var initialdatatransbank = new TrasnbanckModel1(token: "token", url: "url");

    return Container(
      color: Colors.white30,
      child: FutureBuilder(
        //  initialData: initialdatatransbank,
        future:
            enviardatosyobtenerurl(), //llamada http y pbtiene la lista de datos

        builder:
            (BuildContext context, AsyncSnapshot<TrasnbanckModel1> snapshot) {
          //pasa el esnap chop a una lsita
          //vamos a enviar la data del snapshop
          if (snapshot.hasData) {
            //        guardarsolicituddecompra(context, ordendecompra);
            return Container(
                child: render_webview(
                    snapshot.data!.token.toString(),
                    snapshot.data!.url
                        .toString())); // Card_swipeer(peliculas_list: snapshot.data); //clase
          }
          if (snapshot.hasError) {
            return Container(
                height: 400,
                child: Center(
                    child: Column(
                  children: [
                    util_texts_black2_agregattamano("error", 2),
                    CircularProgressIndicator(),
                  ],
                )));
          }
          if (!snapshot.hasData) {
            return Container(
                height: 400,
                child: Center(
                    child: Column(
                  children: [
                    util_texts_black2_agregattamano("Cargando", 2),
                    CircularProgressIndicator(),
                  ],
                )));
          }

          return Container(
              padding: EdgeInsets.only(top: 100),
              height: 400,
              child: Center(
                  child: Column(
                children: [
                  // util_texts_black2_agregattamano("Cargando", 1),
                  util_texts_white_2_agregattamano("Loading..", 1),
                  CircularProgressIndicator(),
                ],
              )));
        },
      ),
    );
  }

  //en teoria este ya me retorna el model
  Future<TrasnbanckModel1> enviardatosyobtenerurl() async {
    final TrasnbanckModel1 model_trans;
    //
    final authdata = {
      'Content-Type': 'application/json',
    };
    //
    final data_order = {
      "uid": ordendecompra_p.keyUid,
      "buyOrder": ordendecompra_p.buyOrder,
      "sessionId": "11111",
      "amount": total_int_p,
    };

    var url_test_v4 =
        "http://salonhousev2.herokuapp.com/pagarv5/uid_usuario123";

    final Uri url_transaccion = Uri.parse(url_test_v4); //queryR

    //guardar orden de compra para verificarla en el perfil usuario

    //mibb
    var response = await Dio().post(
      url_transaccion.toString(),
      options: Options(headers: authdata), //api key
      data: data_order, //buy order...
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );
    print(
        "-here la respuesta obtenermos la pagina de apgos !!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(response); //regresa todo el html5 correctamente para pagar

    model_trans = TrasnbanckModel1.fromJson(response.data);
    token_api = model_trans.token;
    url_api = model_trans.url;
    print(token_api);
    return model_trans;
  }

  //tambien retorna el render html
  Future obtenerdata2() async {
    // InAppWebViewController? _webViewControlle_p;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('http://salonhousev2.herokuapp.com/pagarv5/uid_usuario'));
    //despues veo qeu modelo de datos envio con datos d ecomprador solo datos necesarios de compra
    request.body = json.encode({
      {
        "uid": ordendecompra_p.keyUid,
        "buyOrder": ordendecompra_p.buyOrder,
        "sessionId": "11111",
        "amount": ordendecompra_p.totalString,
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    //print(await response.stream.bytesToString());//imprime el json

    try {
      if (response != null) {
        print("obteniendo data!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        await response.stream.bytesToString().then((value) {
          print("mi JSON  " + value); //funciona
          //  print(jsonDecode(value)['token']);
          // print(jsonDecode(value)['url']);

          url_api = jsonDecode(value)['url'];
          token_api = jsonDecode(value)['token'];
          return TrasnbanckModel1(token: token_api, url: url_api);

          // var nameError = jsonResponse["errors"]["name"][0];
        });
      }
    } catch (e) {}
  }

  Widget render_webview(
    String token_1,
    String url_1,
  ) {
    InAppWebViewController? webView_controler;
    return Container(
        child: Column(children: <Widget>[
      Expanded(
        child: InAppWebView(
          initialData: InAppWebViewInitialData(

              //muestra data:text/;charset
              data: """ <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>pagar con webpay</title>
</head>
<body>
    <form action="${url_1.toString()}" id='webpay-form' method="POST">

        <input type="hidden" name="TBK_TOKEN" value="${token_1.toString()}"/>
        <input type="submit" value="pulsar para  pagar" />
    </form>

    <script>
        window.onload=function(){
            document.getElementById('webpay-form').submit()}
        </script>
</body>
</html>"""),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
                // debuggingEnabled: true,

                javaScriptCanOpenWindowsAutomatically: true),
            android: AndroidInAppWebViewOptions(

                //debuggingEnabled: true,
                // on Android you need to set supportMultipleWindows to true,
                // otherwise the onCreateWindow event won't be called
                useHybridComposition: true,
                supportMultipleWindows: true),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            webView_controler = controller;

            controller.addJavaScriptHandler(
              handlerName: 'jesuscanal',
              callback: (arg) {
                //aqui reguntamos en la lista , si esta lista es =1
                print("buscando argumentos: ");

                print(arg);

                if (arg.length == 1) {
                  print('pago exitoso ');
                }
                // return {'bar': 'bar_value', 'baz': 'baz_value'};
              },
            );
          },
          onConsoleMessage: (controller, consoleMessage) {
            //aqui siempre me imprime que se coecto bien con mi api pero no el estado
            print("consola:");
            print(consoleMessage);
            bool comunicar = false;

            if (consoleMessage.toString().length > 0 && comunicar != true) {
              guardarsolicituddecompra(context, ordendecompra_p);
              comunicar = true;
            }
            //flutter run --no-sound-null-safety

            // it will print: {message: {"bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
          },
        ),
      ),
    ]));
  }

  void guardarsolicituddecompra(
      BuildContext context, Orders ordendecompra) async {
    print("RESERVANDO");
    //revisar el de abajo esta todo
    Provider_PerfilUsuario().agregarmicompra(ordendecompra, context);

    //Provider_PerfilUsuario().avisaradmins(ordendecompra, context);
  }

  //
}
