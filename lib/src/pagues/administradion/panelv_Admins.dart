import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salonhouse/src/models/orders.dart';
import 'package:http/http.dart' as http;

import 'package:salonhouse/src/models/turnos.dart';
import 'package:salonhouse/src/models/usuario_model.dart';
import 'package:salonhouse/src/pagues/administradion/provider_paneladmin/panel_control_admin.dart';
import 'package:salonhouse/src/pagues/compras/pagarwebpay_v4.dart';
import 'package:salonhouse/src/preferencias_usuario/preferences_user.dart';

import 'package:salonhouse/src/providers/login/provider_perfilusuario.dart';
import 'package:salonhouse/src/services_push/push_notification.dart';
import 'package:salonhouse/src/utils/utils.dart';
import 'package:salonhouse/src/utils/utils_textos.dart';

class Panel_Admin extends StatefulWidget {
  // Panel_Admin({Key? key}) : super(key: key);

  @override
  _Panel_AdminState createState() => _Panel_AdminState();
}

class _Panel_AdminState extends State<Panel_Admin> {
  void redibuja() {
    //debe ser lalamado dentro de la clase o no sobreescribe es lo qeu entiendo
    setState(() {
      //  lista_productosen_carrito.add(producto);
      print("setstate");
    });
  }

  var busqueda1 = FirebaseFirestore.instance
      .collection('Orders_admin')
      .doc("peluqueuria")
      .collection('general')
      // .limitToLast(2)
      .orderBy('buyOrder', descending: true)
      // .limitToLast(2)
      .snapshots();
  var busqueda2 = FirebaseFirestore.instance
      .collection('Orders_users')
      .doc("peluqueuria")
      .collection('general')
      .snapshots();
  var busqueda3_workers = FirebaseFirestore.instance
      .collection('Users')
      .doc("workers")
      .collection('turnos')
      .orderBy('timestamp', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    //_asignarenfirebase_workers("peluqeuria"); //crea un usuario en turno nuevo
    return Container(
        child: // _productos_firebase(context),
            ListView(
      children: [
        Center(child: Text("panel de ventas2")),
        _swich_onlocal(),
        _data1(),
      ],
    ));
  }

  bool recinbir_pedidos = false;
  Widget _swich_onlocal() {
    var _prefusers = PreferenciasUsuario();
    if (_prefusers.atendiendo != false) {
      setState(() {
        recinbir_pedidos = true;
      });
    } /*
    if (_prefusers.atendiendo != true) {
      recinbir_pedidos = false;
    }*/

    return Container(
      child: Row(
        children: [
          util_texts_black2_agregattamano("Recibir pedidos", 0.5),
          Switch(
              value: recinbir_pedidos,
              activeTrackColor: Colors.green,
              activeColor: Colors.greenAccent,
              onChanged: (value) {
                if (value == true) {
                  _prefusers.atendiendo = true;
                  setState(() {
                    recinbir_pedidos = true;
                  });

                  print(_prefusers.atendiendo);

                  _actualizarestadorecibirpedidos(1);
                }
                if (value == false) {
                  _prefusers.atendiendo = false;
                  setState(() {
                    recinbir_pedidos = false;
                  });

                  print(_prefusers.atendiendo);

                  _actualizarestadorecibirpedidos(2);
                }
              }),
        ],
      ),
    );
  }

  _actualizarestadorecibirpedidos(int i) async {
    CollectionReference adminref_info =
        FirebaseFirestore.instance.collection('Users');
    var _prefuser = PreferenciasUsuario();

    if (i == 1) {
      var usuario = new Usuario(
          keyBusqueda: "keyBusqueda",
          keyUsuario: _prefuser.token,
          notifiUid: _prefuser.token_notifi,
          calificaion: 5,
          cargo: "admin",
          fotodePerfilUri: _prefuser.foto,
          direccion: _prefuser.direccion,
          latitud: _prefuser.latitud,
          longitud: _prefuser.longitud,
          teleonoUsuario: _prefuser.telefono,
          usuarioNombre: _prefuser.nombre);
      adminref_info.doc("Admin").set(usuario.toJson()).then((value) =>
          mostrardialogbuttonshetv2_selec(context, "local Abrierto"));
    }
    if (i == 2) {
      var usuario = new Usuario(
          keyBusqueda: "keyBusqueda",
          keyUsuario: _prefuser.token,
          notifiUid: "",
          calificaion: 5,
          cargo: "admin",
          fotodePerfilUri: _prefuser.foto,
          direccion: _prefuser.direccion,
          latitud: _prefuser.latitud,
          longitud: _prefuser.longitud,
          teleonoUsuario: _prefuser.telefono,
          usuarioNombre: _prefuser.nombre);
      _prefuser.atendiendo = false;
      adminref_info.doc("Admin").set(usuario.toJson()).then(
          (value) => mostrardialogbuttonshetv2_selec(context, "local cerrado"));
    }
  }

  Widget _data1() {
    return StreamBuilder(
        stream: busqueda1,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot_data) {
          //si no tinene nada
          if (!snapshot_data.hasData) {
            return Container(
                child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Text('buscando '),
                CircularProgressIndicator(),
              ],
            ));
          }
          final _screensize = MediaQuery.of(context).size;
          final double itemHeight =
              (_screensize.height - kToolbarHeight - 24) / 2;
          final double itemWidth = _screensize.width / 2;
          final double altov2 = _screensize.height * 0.6;
          //
          //int index = snapshot_data.data!.docs.length;
          //List<Orders> orderslist = [];

          return GridView.count(
            crossAxisCount: 1,
            scrollDirection: Axis.vertical,
            childAspectRatio: 1.0,
            padding: const EdgeInsets.all(4.0),
            //childAspectRatio: (itemWidth / altov2), // (itemWidth / 370),
            mainAxisSpacing: 5.0, //espacios  arriba y abajo
            crossAxisSpacing: 5.0, //espacio  laterales
            shrinkWrap: true,
            physics: ScrollPhysics(),

            children: snapshot_data.data!.docs.map((document) {
              var _data_var = document.data();
              // var _data =Orders.fromJson(document); //documentSnapshot.data();
              //Orders orden = ordersFromJson(document.toString());

              print('Stream!!!!!!!!!!!!!!!!!!');
              print(document.data()); //Instance of '_JsonQueryDocumentSnapshot'

              var order2 = Orders.fromDocument(document);
              print("Orden:    " + document['buyOrder']);
              print("Orden2:    " + order2.buyOrder);
              print("worker:    " + document['nombreworker']);
              //color de la casilla autoriado
              var color_estado_autorizar = Colors.yellow[200];
              var estado_autorizado = "AUTORIZED";
              bool verwidget = false;

              if (estado_autorizado == order2.status) {
                color_estado_autorizar = Colors.green[400];
                verwidget = true;
              }
              int i = 1; //order2.idPagocomletado as int;

              final _screensize = MediaQuery.of(context).size;
              //NO borrar nunca
              final tarjeta3_contenido = Container(
                // padding: const EdgeInsets.only(left: 10),
                //  height: _screensize.height * 0.5,
                //child: Text(document['buyOrder']),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.indigo[300],

                        //  padding: const EdgeInsets.all(5.0),
                        //    alignment: Alignment.topLeft,
                        width: double.infinity, // _screensize.height * 0.2,
                        // height: _screensize.height * 0.4, //double.maxFinite, //
                        //  margin: EdgeInsets.only(right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                //dats de fecha
                                children: [
                                  Text(order2.buyOrder),
                                  Text(order2.fechaReservacion),
                                  // Text(order2.status),
                                ],
                                //estado
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Row(children: [
                                IconButton(
                                  onPressed: () {
                                    //aqui no necesito confirmar nada

                                    var dataconfirmar = {
                                      "uid": "usuario_alskdfjalksaj",
                                      "buyOrder": order2.buyOrder,
                                      "sessionId": "11111",
                                      "amount": "25000"
                                    };

                                    FutureBuilder(
                                      future: confirmar_estadodepago(
                                          dataconfirmar,
                                          order2.buyOrder,
                                          order2.keyUid,
                                          order2.notifiuidCliente),
                                      // initialData: InitialData,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return CircularProgressIndicator(
                                              backgroundColor: Colors.blue);
                                        } else {
                                          print(snapshot.data);
                                          return mostraralerta(context,
                                              "procesando"); //snapshot.data);

                                          //return snapshot.data;
                                        }
                                      },
                                    );
                                    //este es el iciono de dinero
                                    //verificar el estado online
                                  },
                                  icon: Icon(Icons.offline_bolt),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      color: color_estado_autorizar,
                                      child: Text(order2.status)),
                                ),
                              ]),

                              //estado
                            ),
                          ],
                        ),
                      ),
                    ),
                    //2. informe cliente //foto,pedido
                    Container(
                      width: double.infinity,
                      //alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, //espacios iguaes
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            // mostrar info usuario
                            child: GestureDetector(
                              onTap: () {
                                print("mostrar info usuario");
                                _mostrarinformacionusuario(context, order2);
                              },
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(order2.fotografia),
                                    //    'https://d8bwfgv5erevs.cloudfront.net/cdn/13/images/curso-online-perfil-psicologico-de-una-persona_l_primaria_1_1524733601.jpg'),
                                    radius: 25.0,
                                    backgroundColor: Colors.red,
                                  ),
                                  Container(
                                    width: itemWidth,
                                    child: Text(
                                      order2.nombreCliente,
                                      overflow: TextOverflow.ellipsis,
                                      // maxLines: 1,
                                      softWrap: true,
                                      //overflow: TextOverflow.ellipsis, //cuando el texto no cabe pone puntitos
                                      // style: Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                  /* RichText(
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 12.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        text: order2.nombreCliente),
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    _mostraralerta_lista_productos(
                                        context,
                                        order2.productoscarrito_order,
                                        order2.totalInt);
                                    //este es el iciono de dinero
                                    // print(document);
                                    //  print(document['nombre']);
                                  },
                                  icon: Icon(Icons.list),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Ver orden",
                                    overflow: TextOverflow
                                        .ellipsis, //cuando el texto no cabe pone puntitos
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // pausa y titulo se ve mejor asi
                    Center(child: Text(order2.status)),
                    //3. asignar personal
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              //mostraralerta_steper_estadopedido(context, 3);

                              _worker_asignar_v2(order2);
                              // mostrar_fulldialog(context,2); //es lo que quiero pero no muestra el steper
                            },
                            icon: Icon(Icons.person_add),
                          ),
                          Text(
                            "Asignar a ",
                            overflow: TextOverflow
                                .ellipsis, //cuando el texto no cabe pone puntitos
                            //style: Theme.of(context).textTheme.caption,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              children: <Widget>[
                                Text("Total: " + order2.totalString),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    //mostrar algun icono extra para el pedido
                    // Container(child: _steper_model_3_simple(context)),
                    //4. info user estado pedido
                    Flexible(
                        child: _steper_model_informar_usuarios(
                      context,
                      order2.idPagocomletado,
                      order2,
                      document['nombreworker'],
                      document['fotoworker'],
                      document['keyworker'],
                    )), //_steper_model_3(context, i)),
                  ],
                ),
              );

              final tarjeta4_bordes = Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                child: tarjeta3_contenido, //tr 3
              );
              return tarjeta4_bordes;
              /*GestureDetector(
                  child:tarjeta ,
                  onTap: ,
                );*/

              //
            }).toList(),
          );
        });
  }

//----1. estado de pago  22/07/2021
  Future<String> confirmar_estadodepago(Map<String, String> dataconfirmar,
      String buyOrder, String keyuid, String notifiuid_cliente) async {
    //iniciamos peticion
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('http://salonhousev2.herokuapp.com/confirmarpago/asdf'));
    request.body = jsonEncode(dataconfirmar);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
/*Response response = await _dio.post(getAddToCartURL,
  options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json",
  }),
  data: jsonEncode(params),
); */
    if (response.statusCode == 200) {
      print("200");
      // print(await response.stream.bytesToString()); //recibo AUTH
      //print()

      String pagoautorizado = await response.stream.bytesToString();
      try {
        await _panel_steper_informar_cliente(
            buyOrder, 1, keyuid, "recibido", notifiuid_cliente); //
        await _status_admin_autorizado(buyOrder, 1, keyuid);
      } catch (e) {}

      return pagoautorizado;
    } else {
      print(response.reasonPhrase);
      return ("Sin pagar ");
    }
  }

  //1.1autorizar en base admin
  Future _status_admin_autorizado(
      String buyorder, int pagoautorizado, String keyuid) async {
    var busqueda3 = FirebaseFirestore.instance
        .collection('Orders_admin')
        .doc("peluqueuria")
        .collection('general')
        .doc(buyorder);
    await busqueda3.update({'status': 'AUTORIZED'}).then((value) => () {
          print("actualizado en el panel adminsitrativo");
          // _panel_steper_informar_cliente(buyorder, 1, keyuid);
        }); //1. pendiente,2pagado,3preparando,enviando
  }

//-2. aqui quiero empezar con los widgesst de mostrar informacion usuario y lista de compras del cliente
  _mostrarinformacionusuario(BuildContext context, Orders orden_cliente) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(' informacion Cliente '),
            content: ListView(
              scrollDirection: Axis.vertical,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("hora Servicio: " + orden_cliente.horaServicios),
                Text("fecha: " + orden_cliente.fechaServicios),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                      image: NetworkImage(
                          orden_cliente.fotografia), //cargar imgane existente
                      placeholder:
                          AssetImage('jar-loading.gif'), //img mientras carga
                      fit: BoxFit.cover,
                      height: 209 //ancho posiible
                      ),
                ),
                Text("Nombre : " + orden_cliente.nombreCliente),
                Text("Telefono : " + orden_cliente.telefono),
                Text("direccion : " + orden_cliente.direccion),
                Text("total: " + orden_cliente.totalString),
                Text(""),
                Text(""),
                Text("Ver ubicacion del domicilio?"),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('ir a maps')),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('NO'))
            ],
          );
        });
  }

//3, mostrar lista d eproductos
  _mostraralerta_lista_productos(BuildContext context,
      List<Productoscarrito_order> lista_prodcut_alert, int total_int) {
    int unidades = lista_prodcut_alert.length;

    final _screensize = MediaQuery.of(context).size;

    final double itemHeight = (_screensize.height - kToolbarHeight - 24) / 2;
    final double itemWidth = _screensize.width / 2;
    final double altov2 = _screensize.height * 0.7;
    return showDialog(
        context: context,
        builder: (context) {
          //aqui bien

          return Container(
            child: AlertDialog(
              title: Text(' Servicios'),
              content: Container(
                width: double.maxFinite,
                height: double.infinity,
                child: ListView(
                  children: <Widget>[
                    Text('cantidad:  $unidades'),
                    Text('Total: ${total_int}'),
                    GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      childAspectRatio:
                          (itemWidth / altov2), // (itemWidth / 370),
                      mainAxisSpacing: 5.0, //espacios  arriba y abajo
                      crossAxisSpacing: 5.0, //espacio  laterales
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      //controller: _pagueController,
                      children: lista_prodcut_alert.map((document) {
                        print('Stream!!!!!!!!!!!!!!!!!!');
                        print(document.nombre);
                        // final tarjeta = Card(child: Text(document['nombre']));
                        final _screensize = MediaQuery.of(context).size;
                        final tarjeta2 = Container(
                          // width: _screensize.height * 0.4,
                          // height: double.maxFinite, // _screensize.height * 0.4,
                          //  margin: EdgeInsets.only(right: 15.0),
                          child: Column(
                            children: <Widget>[
                              Hero(
                                tag: document
                                    .nombre, //cambiamos el id unico para que reciba datos
                                child: Stack(children: <Widget>[
                                  ClipRRect(
                                    //wiget circular
                                    borderRadius: BorderRadius.circular(20),
                                    child: FadeInImage(
                                      //IMAGEN
                                      image: NetworkImage(document
                                          .fotoString), //cargar imgane existente
                                      placeholder: AssetImage(
                                          'assets/no-image.png'), //img mientras carga
                                      fit: BoxFit.cover,
                                      width: _screensize.height * 0.4,
                                      height:
                                          200, //_screensize.height * 0.3 //160, //ancho posiible
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5.0),
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        //click en el container que tiene la imagen
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://static.vecteezy.com/system/resources/previews/000/583/901/non_2x/remove-from-cart-icon-vector.jpg'),
                                        radius: 20.0,
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                document.nombre,
                                overflow: TextOverflow
                                    .ellipsis, //cuando el texto no cabe pone puntitos
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.monetization_on)),
                                  Text(
                                    document.precio,
                                    overflow: TextOverflow
                                        .ellipsis, //cuando el texto no cabe pone puntitos
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              //en teoria aqui acabo el primer widget !!!!!
                            ],
                          ),
                        );

                        final tarjeta3 = Container(
                          child: Text('hola'),
                        );
                        return tarjeta2;
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    child: Text('ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            ),
          );
        });
  }

//4. mostrar ociones y controlar estados del servicio
  Widget _steper_model_informar_usuarios(BuildContext context, int i,
      Orders orders, String nombreworker, String fotoworker, String keyworker) {
    print("steper model ficha worker");
    // print(orders.toJson());
    print(nombreworker);
    // var orden_required = ordersFromJson(orders.toJson().toString());

    //lista d elos puntos

    List<Step> step_list = [
      Step(
        title: Text("solicitada"),
        subtitle: Text("orden recibida "),
        content: Text("hola"), // _seleccionar_categorias(context),
        isActive: i == 0,
        state: i >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Recibido"),
        subtitle: Text("Pedido autorizado !"),
        content: Card(
            child: Text(
                "El establecimiento ha recibido su pedido , pronto se le asignara el debido delivery")),
        isActive: i == 1,
        state: i >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Preparando detalles"),
        content: Text("estamos preparando su pedido "),
        isActive: i == 2,
        state: i >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Enviar"),
        content: Column(
          children: [
            Text("Personal asignado :"),
            // _ficha_domicilios(orders),
            //fecha de entrega
            Card(
              /* shape: StadiumBorder(
        side: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),*/
              //borde simple redondo
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  //datos basicos
                  Column(
                    children: [
                      //_Qrlogo
                      Card(
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: IconButton(
                                  icon: Icon(Icons.qr_code), onPressed: null))),
                      //--Fechas
                      Container(
                        padding: EdgeInsets.all(5.0),
                        alignment: Alignment.topRight,
                        child: Column(
                          children: <Widget>[
                            Text(orders.timestamp),
                            Text(orders.fechaServicios),
                            Text(orders.horaServicios),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //opciones pedido, persona que lo entrega
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        // --- Foto user
                        ClipRRect(
                          //wiget circular

                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            //IMAGEN
                            image: NetworkImage(fotoworker),
                            //model.getbackgroundimage()), //cargar imgane existente
                            //  "https://i.pinimg.com/236x/b3/64/65/b36465fd8703f4b05c5d735b50ffb128.jpg"), //cargar imgane existente

                            placeholder: AssetImage(
                                'assets/no-image.png'), //'assets/jar-loading.gif'), //img mientras carga
                            fit: BoxFit.cover,
                            height: 250, //ancho posiible
                            width: double.infinity,
                          ),
                        ),
                        Text(""),
                        Center(child: Text(nombreworker)),
                        Center(child: Text("cargo :Profesional")),
                        Center(child: Text("cargo :Puntaje")),

                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          disabledColor: Colors.amber,
                          child: Text("Delivery completado"),
                          splashColor: Colors.amber,
                          color: Colors.green,
                          onPressed: () {
                            print("Hola Raised Button");
                          },
                        ),
                        Text(""),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          disabledColor: Colors.amber,
                          child: Text("Cancelar servicio"),
                          splashColor: Colors.amber,
                          color: Colors.red,
                          onPressed: () {
                            print("Hola Raised Button");
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        isActive: i == 3,
        state: i >= 3 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Finalizado"),
        content: Text("Gracias por su compra !"),
        isActive: i == 2,
        state: i >= 2 ? StepState.complete : StepState.disabled,
      ),
    ];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.black, width: 1),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        //color: PURPLE,
        child: Stepper(
          //physics: ClampingScrollPhysics(), //scroll
          physics: ClampingScrollPhysics(),
          steps: step_list, //lista
          type: StepperType.vertical,
          currentStep: i, //this._index, //valor
          onStepTapped: (index) {
            setState(() {
              i = index;
            });
          },

          onStepCancel: null,
          onStepContinue: () async {
            //print("informar estado " + i.toString());
            //1 -recibido: cuando el establecimiento recibe le pedido y ambos tienen una copia
            //2.-preparando: alistando detalles
            //3. _envio: su pedido esta listo .
            print("estado servicio");
            print(i);
            if (i == 1) {
              //cambiar el estado de esta y la de mi usuario
              //  i = i + 1;

              try {
                await _panel_steper_informar_cliente(orders.buyOrder, 2,
                    orders.keyUid, "Recibido", orders.notifiuidCliente);
                await _panel_steper_estados_pedido_recibido(
                    orders.buyOrder, 2, orders.keyUid);
              } catch (e) {}
            }
            if (i == 2) {
              await _panel_steper_informar_cliente(orders.buyOrder, 3,
                  orders.keyUid, "preparando", orders.notifiuidCliente);
              await _panel_steper_estados_pedido_recibido(
                  orders.buyOrder, 3, orders.keyUid);
            }
            if (i == 3) {
              //debe asignar el personal que le atendera
              mostrardialogbuttonshetv2_selec(
                  context, "ingrese persona que entrega el pedido");
              //mostraralerta(context, "asige el personal que enviara el pedido ");
            }
          },
        ),
      ),
    );
  }

//4.1 aqui quiero controlar el cambio en la base de datos y ademas crear la notificacion de una vez
  //4.1.1. controlar el estado del servicio y envio //recibido, enviando..etc
  Future _panel_steper_estados_pedido_recibido(
      String buyorder, int i, String keyuid) async {
    var busqueda3 = FirebaseFirestore.instance
        .collection('Orders_admin')
        .doc("peluqueuria")
        .collection('general')
        .doc(buyorder);
    await busqueda3.update({
      // 'status': 'AUTORIZED',
      'id_pagocomletado': i,
    }).then((value) => () {
          print("actualizado en el panel adminsitrativo");
        }); //1. pendiente,2pagado,3preparando,enviando
  }

//4.2 informar clientes //5.3 notificaciones - ya el post esta _notificarestado y pide el titulo mensaje y uidnotifi
  Future _panel_steper_informar_cliente(String buyorder, int i, String keyuid,
      String estado, String notifiuid_cliente_vq) async {
    var busqueda2 = FirebaseFirestore.instance
        .collection('Orders_users')
        .doc("usuarios")
        .collection(keyuid)
        .doc(buyorder);
    //  .orderBy('buyOrder', descending: true)
    //.snapshots();
    await _notificar_estado_pedido_cliente(
        "Estado pedido", estado, notifiuid_cliente_vq);
    await busqueda2.update({
      'status': 'AUTORIZED',
      'id_pagocomletado': i,
    }).then((value) => () {
          print("actualizado en el usuarios");

          // _status_admin_autorizado(buyorder, i, keyuid);
          // print("$estadodepago");
        }); //1. pendiente,2pagado,3preparando,enviando
  }

//5.0.1 lleno firebase cion un modelo worker
  _asignarenfirebase_workers(String categoria) {
//key,nombre y foto ,timestamp
    var workers_bbddd = FirebaseFirestore.instance
        .collection('Users')
        .doc("workers")
        .collection('turnos'); //uid
    //traigo la colleccion de usaurios
    var turno = Turno(
        timestamp: "111",
        uid: "asldkfjaskl",
        fotoString:
            "data:image/jpeg;base64,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",
        nombre: "carla",
        tel: "9asdj",
        profesion: "manucurista",
        disponible: false,
        notifi: 'notifiuid');
    workers_bbddd.add(turno.toJson());
  }

//5.1 signar usuarios v2
  _worker_asignar_v2(Orders orden_w) {
    print("worker_v2 735");

    var users_turno = StreamBuilder(
        stream: busqueda3_workers,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot_data) {
          //si no tinene nada
          if (!snapshot_data.hasData) {
            return Container(
                child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Text('buscando '),
                CircularProgressIndicator(),
              ],
            ));
          }
          final _screensize = MediaQuery.of(context).size;
          final double itemHeight =
              (_screensize.height - kToolbarHeight - 24) / 2;
          final double itemWidth = _screensize.width / 2;
          final double altov2 = _screensize.height * 0.6;

          return GridView.count(
            crossAxisCount: 1,
            scrollDirection: Axis.vertical,
            childAspectRatio: 1.0,
            padding: const EdgeInsets.all(4.0),
            //childAspectRatio: (itemWidth / altov2), // (itemWidth / 370),
            mainAxisSpacing: 5.0, //espacios  arriba y abajo
            crossAxisSpacing: 5.0, //espacio  laterales
            shrinkWrap: true,
            physics: ScrollPhysics(),

            children: snapshot_data.data!.docs.map((document) {
              var _data_var = document.data();
              // var _data =Orders.fromJson(document); //documentSnapshot.data();
              //Orders orden = ordersFromJson(document.toString());

              print('Stream 1!!!!!!!!!!!!!!!!!!');
              // print(document.data()); //Instance of '_JsonQueryDocumentSnapshot'

              // var worker_doc = Usuario.fromDocument(document);
              Turno worker_doc = Turno.fromdocument(document);

              // var worker_doc = Turno.fromDocument(document);
              print("workers:    " + document["nombre"]);
              print("workers:    " + worker_doc.nombre);
              //color de la casilla autoriado
              var color_estado_autorizar = Colors.yellow[200];
              //   var estado_autorizado = "AUTORIZED";
              // bool verwidget = false;

              /*  if (estado_autorizado == workers.status) {
                color_estado_autorizar = Colors.green[400];
                verwidget = true;
              }*/

              var one = int.parse(worker_doc.timestamp);
              var fecha_deingres_del_worker =
                  new DateTime.fromMillisecondsSinceEpoch(one); //
              var dos = one / 10;

              final _screensize = MediaQuery.of(context).size;
              //NO borrar nunca
              final tarjeta2 = Container(
                width: _screensize.height * 0.4,
                height: double.maxFinite, // _screensize.height * 0.4,
                //  margin: EdgeInsets.only(right: 15.0),
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: worker_doc
                          .uid, //cambiamos el id unico para que reciba datos
                      child: Stack(children: <Widget>[
                        ClipRRect(
                          //wiget circular
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            //IMAGEN
                            image: NetworkImage(worker_doc
                                .fotoString), //cargar imgane existente
                            placeholder: AssetImage(
                                'assets/no-image.png'), //img mientras carga
                            fit: BoxFit.cover,
                            width: _screensize.height * 0.4,
                            height:
                                210, //_screensize.height * 0.3 //160, //ancho posiible
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              //click en el container que tiene la imagen
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://static.vecteezy.com/system/resources/previews/000/583/901/non_2x/remove-from-cart-icon-vector.jpg'),
                              radius: 20.0,
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 150, 0, 0),
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  worker_doc.nombre,
                                  overflow: TextOverflow
                                      .ellipsis, //cuando el texto no cabe pone puntitos
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  worker_doc.profesion,
                                  overflow: TextOverflow
                                      .ellipsis, //cuando el texto no cabe pone puntitos
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Text(
                                  dos.toString(),
                                  overflow: TextOverflow
                                      .ellipsis, //cuando el texto no cabe pone puntitos
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),

                    /* ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {
                        print("Hola elevated Button");
                      },
                      child: Text("Asignar servicio"),
                    ),*/
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        disabledColor: Colors.amber,
                        child: Text("Asignar servicio"),
                        splashColor: Colors.amber,
                        color: Colors.green,
                        onPressed: () {
                          print("Hola Raised Button");
                          //aqui obtengo los datos del worker y los agrego a la orden
                          try {
                            //actualizamos cliente worker y panel
                            _panel_worker_andmin(
                                orden_w.buyOrder,
                                3,
                                worker_doc.nombre,
                                worker_doc.fotoString.toString(),
                                worker_doc
                                    .uid); //actualizar ficha usuario, creo qeu ya
                            _panel_informar_cliente(
                                orden_w.buyOrder,
                                3,
                                worker_doc.nombre.toString(),
                                worker_doc.fotoString,
                                worker_doc.uid,
                                orden_w.keyUid);
                            _panel_informar_worker(
                                orden_w.buyOrder,
                                3,
                                worker_doc.nombre.toString(),
                                worker_doc.fotoString,
                                worker_doc.uid,
                                orden_w.keyUid,
                                orden_w);

                            mostrardialogbuttonshetv2_selec(
                                context, "Complete!");

                            _enviarnotificaiones(
                                orden_w.notifiuidCliente, worker_doc.notifi);

                            //noti cliente y worker
                            //  _notificar_estado_pedido_cliente("Asignado","delivery listo", orden_w.notifiuidCliente);
                            //_notificar_estado_pedido_cliente("Asignado", "delivery listo", worker_doc);
                          } catch (e) {}
                        }),

                    //en teoria aqui acabo el primer widget !!!!!
                  ],
                ),
              );
              final tarjeta4_bordes = Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                child: tarjeta2, //tr 3
              );
              return tarjeta2;
              /*GestureDetector(
                  child:tarjeta ,
                  onTap: ,
                );*/

              //
            }).toList(),
          );
        });

    final _screensize = MediaQuery.of(context).size;
    final double itemHeight = (_screensize.height - kToolbarHeight - 24) / 2;
    final double itemWidth = _screensize.width / 2;
    final double altov2 = _screensize.height * 0.7;
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: Duration(
          milliseconds:
              400), // How long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // Makes widget fullscreen
        return SizedBox.expand(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: SizedBox.expand(
                    child: users_turno), //aqui mostraba el logo de flutter
              ),
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Dismiss',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

//5.2.1funcion  reajustar tabla y asignar personal en la tabla principal de admin
  Future _panel_worker_andmin(
    String buyorder,
    int i,
    String nombreworker,
    String fotoworker,
    String keyworker,
  ) async {
    var busqueda3 = FirebaseFirestore.instance
        .collection('Orders_admin')
        .doc("peluqueuria")
        .collection('general')
        .doc(buyorder);
    await busqueda3.update({
      // 'status': 'AUTORIZED',
      'id_pagocomletado': i,
      "nombreworker": nombreworker,
      "fotoworker": fotoworker,
      "keyworker": keyworker,
    }).then((value) => () {
          print("actualizado en el panel adminsitrativo workers y entregado");

          // print("$estadodepago");
        }); //1. pendiente,2pagado,3preparando,enviando
  }

  //5.2.2
  Future _panel_informar_cliente(
    String buyorder,
    int i,
    String nombreworker,
    String fotoworker,
    String keyworker,
    String key_cliente,
  ) async {
    var busqueda2 = FirebaseFirestore.instance
        .collection('Orders_users')
        .doc("usuarios")
        .collection(key_cliente)
        .doc(buyorder);
    //  .orderBy('buyOrder', descending: true)
    //.snapshots();

    await busqueda2.update({
      // 'status': 'AUTORIZED',
      'id_pagocomletado': i,
      'nombreworker': nombreworker,
      "fotoworker": fotoworker,
      "keyworker": keyworker,
    }).then((value) => () {
          print("actualizado en el usuarios informacion del worker ");
          mostrardialogbuttonshet(context, "asignacion completa ");
          // _status_admin_autorizado(buyorder, i, keyuid);
          // print("$estadodepago");
        }); //1. pendiente,2pagado,3preparando,enviando
  }

  //5.2.3
  Future _panel_informar_worker(
      String buyorder,
      int i,
      String nombreworker,
      String fotoworker,
      String keyworker,
      String key_cliente,
      Orders order_w2de2) async {
    var busqueda2 = FirebaseFirestore.instance
        .collection('workers_rider')
        .doc("workers")
        .collection(keyworker)
        //.collection(key_cliente)
        .doc(buyorder);
    //  .orderBy('buyOrder', descending: true)
    //.snapshots();
    order_w2de2.idPagocomletado = i;
    order_w2de2.nombreworker = nombreworker;
    order_w2de2.fotoworker = fotoworker;
    order_w2de2.keyworker = keyworker;

    await busqueda2
        .set(order_w2de2.toJson()); //1. pendiente,2pagado,3preparando,enviando
  }

//5  worker
  Widget _ficha_domicilios(Orders order_ficha_worker) {
    print((order_ficha_worker.toJson()));
    // var ordernm = ordersFromJson(order_ficha_worker.toJson());

    // print(order_ficha_worker['nombreworker']);
    // print((order_ficha_worker.fotografia));
    return Card(
      /* shape: StadiumBorder(
        side: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),*/
      //borde simple redondo
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: <Widget>[
          //datos basicos
          Column(
            children: [
              //_Qrlogo
              Card(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: IconButton(
                          icon: Icon(Icons.qr_code), onPressed: null))),
              //--Fechas
              Container(
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    Text(order_ficha_worker.timestamp),
                    Text(order_ficha_worker.fechaServicios),
                    Text(order_ficha_worker.horaServicios),
                  ],
                ),
              ),
            ],
          ),
          //opciones pedido, persona que lo entrega
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                // --- Foto user
                ClipRRect(
                  //wiget circular

                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    //IMAGEN
                    image: NetworkImage(order_ficha_worker.fotoworker),
                    //model.getbackgroundimage()), //cargar imgane existente
                    //  "https://i.pinimg.com/236x/b3/64/65/b36465fd8703f4b05c5d735b50ffb128.jpg"), //cargar imgane existente

                    placeholder: AssetImage(
                        'assets/no-image.png'), //'assets/jar-loading.gif'), //img mientras carga
                    fit: BoxFit.cover,
                    height: 250, //ancho posiible
                    width: double.infinity,
                  ),
                ),
                Text(""),
                Center(child: Text(order_ficha_worker.nombreworker.toString())),
                Center(child: Text("cargo :Profesional")),
                Center(child: Text("cargo :Puntaje")),

                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  disabledColor: Colors.amber,
                  child: Text("Delivery completado"),
                  splashColor: Colors.amber,
                  color: Colors.green,
                  onPressed: () {
                    print("Hola Raised Button");
                  },
                ),
                Text(""),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  disabledColor: Colors.amber,
                  child: Text("Cancelar servicio"),
                  splashColor: Colors.amber,
                  color: Colors.red,
                  onPressed: () {
                    print("Hola Raised Button");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

//6. notificaion  una general que solo envie el mensaje al final
  // const admin = require("firebase-admin");
  //mejor hacerlo desde mi servidor web
  _notificar_estado_pedido_cliente(
      String titulo, String mensaje, uid_cliente) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://salonhousev2.herokuapp.com/notifi/123'));
    request.body = json.encode(
        {"uid_notifi": uid_cliente, "titulo": titulo, "mensaje": mensaje});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("notificado");
      mostraralerta(context, "notificado");
    } else {
      print(response.reasonPhrase);
    }
  }

  void _enviarnotificaiones(String notifiuidCliente, String notifi) {
    enviar_nueva_notificacion(
        "cliente",
        "su pedido esta pronto a ser entregado revise su ficha aqui!",
        notifiuidCliente);
    enviar_nueva_notificacion(
        "rider", "tienes asignado un nuvo servicio!", notifi);
  }
}
