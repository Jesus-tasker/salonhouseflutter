import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salonhouse/src/models/materias_elegir.dart';
import 'package:salonhouse/src/models/orders.dart';
import 'package:salonhouse/src/models/turnos.dart';
import 'package:salonhouse/src/pagues/compras/pagarwebpay_v4.dart';
import 'package:salonhouse/src/preferencias_usuario/preferences_user.dart';
import 'package:salonhouse/src/wigetts/card_swiper_.dart';
import 'package:salonhouse/src/wigetts/movies_horizontal.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Home_riders());

class Home_riders extends StatefulWidget {
  @override
  _Home_ridersState createState() => _Home_ridersState();
}

String _nombre = "";
String _foto = "";
String _keyuid = "";

final _pref_user = new PreferenciasUsuario(); //shared preferences

class _Home_ridersState extends State<Home_riders> {
  List<Materias> materiaslist1 = [];
  List<Materias> materiaslista_soloinicio = [];
  int _index = 3; //estado
  ScrollController _scrollController =
      new ScrollController(); //para bajar pantalla en steper widget O-O-*-O

  @override
  Widget build(BuildContext context) {
    if (_pref_user.nombre != null && _pref_user.nombre != "") {
      //keyUID
      // print(pref.token);
      _nombre = _pref_user.nombre;
      //print("navegador:");
      print(_nombre);
      //user.usuarioNombre = nombre;
      //_traerdatosfirebase(keyuid_preference, context);
    }

    if (_pref_user.foto != null && _pref_user.foto != "") {
      //keyUID
      // print(pref.token);
      _foto = _pref_user.foto;
      print("p_user:");
      print(_foto);

      //
      //user.fotodePerfilUri = ""; //esta linea parece causar problemas
      //user.fotodePerfilUri = foto; //esta linea parece causar problemas
    }
    if (_pref_user.token != null && _pref_user.token != "") {
      //keyUID
      // print(pref.token);
      _keyuid = _pref_user.token;
      //print("navegador:");
      print(_keyuid);
      //user.usuarioNombre = nombre;
      //_traerdatosfirebase(keyuid_preference, context);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: null,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(30.0), child: _appbar_info_user()),
        body: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              _appbar_info_user(),
              _data1(),
            ],
          ),
          //_steper_model2(context),
        ),
      ),
    );
  }

  Widget _data1() {
    var worker_listadepedidos = FirebaseFirestore.instance
        .collection('workers_rider')
        .doc("workers")
        .collection(_keyuid)
        .orderBy('buyOrder', descending: true)
        .snapshots();

    //cliente
    /*  var busqueda2 = FirebaseFirestore.instance
        .collection('Orders_users')
        .doc("usuarios")
        .collection(_keyuid)
        .orderBy('buyOrder', descending: true)
        .snapshots();*/
    return StreamBuilder(
        stream: worker_listadepedidos,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot_data) {
          //si no tinene nada
          if (!snapshot_data.hasData) {
            return Container(
                child: Column(
              // scrollDirection: Axis.vertical,
              children: <Widget>[
                Text('buscando  '),
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
                height: _screensize.height * 0.5,
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
                                    /*

                                    var dataconfirmar = {
                                      "uid": "usuario_alskdfjalksaj",
                                      "buyOrder": order2.buyOrder,
                                      "sessionId": "11111",
                                      "amount": "25000"
                                    };                                 

                                    FutureBuilder(
                                      future: confirmar_estadodepago(
                                          dataconfirmar, order2.buyOrder),
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
                                    */
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

                                _mostrarinformacionusuario(
                                    context,
                                    order2,
                                    order2
                                        .fotografia, // document["fotografia"],
                                    order2
                                        .nombreCliente, //document["nombreCliente"],
                                    order2.direccion); //document["direccion"]);
                              },
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(order2.fotografia),
                                    // 'https://d8bwfgv5erevs.cloudfront.net/cdn/13/images/curso-online-perfil-psicologico-de-una-persona_l_primaria_1_1524733601.jpg'),
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
                              mostraralerta_steper_estadopedido(
                                  context, 3, ordendecompra_p);
                              // mostrar_fulldialog(context, 2); //es lo que quiero pero no muestra el steper
                            },
                            icon: Icon(Icons.show_chart),
                          ),
                          Text(
                            "ver Estado ",
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

                    Flexible(
                        child: _steper_model_3(
                      context,
                      order2.idPagocomletado,
                      order2,
                      document['nombreworker'],
                      document['fotoworker'],
                      document['keyworker'],
                    )),
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

  _mostrarinformacionusuario(BuildContext context, Orders orden_cliente,
      String foto_c, String nombre_c, String direccion) async {
    //  var foto = orden_cliente["fotografia"].toString();
    print(orden_cliente.toJson());

    var data = Orders.fromJson(orden_cliente.toJson());
    print(data.fotografia);
    print(data.buyOrder);
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
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Card(
                      //stilo=  Theme.of(context).textTheme.caption;
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("hora Servicio: " + orden_cliente.horaServicios),
                          Text("fecha: " + orden_cliente.fechaServicios),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                                image: NetworkImage(
                                    foto_c), //cargar imgane existente
                                placeholder: AssetImage(
                                    'jar-loading.gif'), //img mientras carga
                                fit: BoxFit.cover,
                                height: 200 //ancho posiible
                                ),
                          ),
                          Text("Nombre : " + orden_cliente.nombreCliente),
                          Text("Telefono : " + orden_cliente.telefono),
                          Text("direccion : " + orden_cliente.direccion),
                          Text("total: " + orden_cliente.totalString),
                          Text(""),
                          Text(""),
                          //   Text("Ver ubicacion del domicilio?"),
                        ],
                      ),
                    ),
                  ),
                ), //aqui mostraba el logo de flutter
              ),
              /* Expanded(
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
              ),*/
            ],
          ),
        );
      },
    );

    /* showDialog(
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
        });*/
  }

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

  ////
  bool buscar_domicilio = false;

  Widget _appbar_info_user() {
    //bool isSwitched = false;
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.black, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              child: GestureDetector(
                onTap: () {
                  //perfil usuario
                  Navigator.pushReplacementNamed(context, 'perfil_user');
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_foto),
                  radius: 25.0,

                  //backgroundColor: Colors.red,
                ),
              ),
            ),
            Container(padding: const EdgeInsets.all(5.0), child: Text(_nombre)),
            Spacer(),
            Switch(
                value: buscar_domicilio,
                activeTrackColor: Colors.yellow,
                activeColor: Colors.orangeAccent,
                onChanged: (value) {
                  if (value = true) {
                    setState(() {
                      buscar_domicilio = value;
                      // print(isSwitched);
                    });
                    _lista_worker_on_turno();
                  }
                })
            /*  IconButton(
                icon: Icon(Icons.next_plan),
                onPressed: () {
                  //  _index++;
                  _index = _index++;
                  print(_index);
                  setState(() {});
                }),*/

            /* Container(
              width: 50.0
              height: 50.0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: FadeInImage(
                    image: NetworkImage(
                        'https://cdn.alfabetajuega.com/wp-content/uploads/2020/04/one-piece-luffy-wano.jpg?width=1200&aspect_ratio=1200:631'), //cargar imgane existente
                    placeholder:
                        AssetImage('assets/no-image.png'), //img mientras carga
                  )),
            ),*/

            // Text('cliente '),
          ],
        ),
      ),
    );
  }

//steper 3 practica para el usuario //ESTA ES LA FINAL QUE FUNCIONA
  Widget _steper_model_3(BuildContext context, int i, Orders orders_stp,
      String nombreworker, String fotoworker, String keyworker) {
    //lista d elos puntos

    List<Step> step_list = [
      Step(
        title: Text("Solicitar"),
        subtitle: Text(
            "Ups parece que aun no has solicitado productos o servicios ,que tal si vemos el menu ?  "),
        content: _seleccionar_categorias(context),
        isActive: i == 0,
        state: i >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Recibido"),
        subtitle: Text("Pedido recibido !"),
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
        title: Text("entrega"),
        content: Column(
          children: [
            Text("Personal asignado :"),
            // _ficha_domicilios(orders_stp3),
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
                            Text(orders_stp.timestamp),
                            Text(orders_stp.fechaServicios),
                            Text(orders_stp.horaServicios),
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
                            _completar_delivery(
                                orders_stp.keyUid,
                                orders_stp.nombreCliente,
                                keyworker,
                                nombreworker,
                                orders_stp.buyOrder,
                                orders_stp.totalString);
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
        content: Text("Gracias por su compra !, pase un  buen dia ."),
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
          /*
          onStepCancel: null,
          onStepContinue: () {
            if (_index < step_list.length - 1) {
              _index = _index + 1;
            } else {
              _index = 0;
              //current_step = 0;
            }
          },*/
        ),
      ),
    );
  }

//////---------- no dio resultado esperado
  mostrar_fulldialog(BuildContext context, int i, Orders orders) {
    List<Step> step_list = [
      Step(
        title: Text("Solicitar"),
        subtitle: Text(
            "Ups parece que aun no has solicitado productos o servicios ,que tal si vemos el menu ?  "),
        content: _seleccionar_categorias(context),
        isActive: i == 0,
        state: i >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Recibido"),
        subtitle: Text("Pedido recibido !"),
        content: Card(
            child: Text(
                "El establecimiento ha recibido su pedido , pronto se le asignara el debido delivery")),
        isActive: i == 1,
        state: i >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Preparando detalles"),
        content: Text(
            "estamos preparando su pedido , le notificaremos una vez este listo  "),
        isActive: i == 2,
        state: i >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("entrega"),
        content: Column(
          children: [
            Text("Personal asignado :"),
            _ficha_domicilios(orders),
            //fecha de entrega
          ],
        ),
        isActive: i == 3,
        state: i >= 3 ? StepState.complete : StepState.disabled,
      ),
    ];
    Widget steper_full = Container(
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
        /*
        onStepCancel: null,
        onStepContinue: () {
          if (_index < step_list.length - 1) {
            _index = _index + 1;
          } else {
            _index = 0;
            //current_step = 0;
          }
        },*/
      ),
    );

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
                    child:
                        steper_full), //aqui mostraba el logo de flutter no muestra el steper
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

  //muestra como un alert dialog , casi perfecto //NO SE USA
  mostraralerta_steper_estadopedido(BuildContext context, int i, Orders orden) {
    List<Step> step_list = [
      Step(
        title: Text("Solicitar"),
        subtitle: Text(
            "Ups parece que aun no has solicitado productos o servicios ,que tal si vemos el menu ?  "),
        content: _seleccionar_categorias(context),
        isActive: i == 0,
        state: i >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Recibido"),
        subtitle: Text("Pedido recibido !"),
        content: Card(
            child: Text(
                "El establecimiento ha recibido su pedido , pronto se le asignara el debido delivery")),
        isActive: i == 1,
        state: i >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Preparando detalles"),
        content: Text(
            "estamos preparando su pedido , le notificaremos una vez este listo  "),
        isActive: i == 2,
        state: i >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("entrega"),
        content: Column(
          children: [
            Text("Personal asignado :"),
            _ficha_domicilios(orden),
            //fecha de entrega
          ],
        ),
        isActive: i == 3,
        state: i >= 3 ? StepState.complete : StepState.disabled,
      ),
    ];

    final steps_widget = Container(
      width: double.infinity,
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
        /*
        onStepCancel: null,
        onStepContinue: () {
          if (_index < step_list.length - 1) {
            _index = _index + 1;
          } else {
            _index = 0;
            //current_step = 0;
          }
        },*/
      ),
    );

    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;

    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            //height: height1,
            width: double.infinity,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Text('Estado domicilio '),
              content: Expanded(
                flex: 5,
                child: SizedBox.expand(
                    child: steps_widget), //aqui mostraba el logo de flutter
              ), //steps_widget, //Text(""),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('ok'))
              ],
            ),
          );
        });
  }

//STEPER --------------------------------------------abajo
  Widget _steper_model2(BuildContext context) {
    //lista d elos puntos
    List<Step> step_list = [
      Step(
        title: Text("Solicitar"),
        subtitle: Text(
            "Ups parece que aun no has solicitado productos o servicios ,que tal si vemos el menu ?  "),
        content: _seleccionar_categorias(context),
        isActive: _index == 0,
        state: _index >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Recibido"),
        subtitle: Text("Pedido recibido !"),
        content: Card(
            child: Text(
                "El establecimiento ha recibido su pedido , pronto se le asignara el debido delivery")),
        isActive: _index == 1,
        state: _index >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("Preparando detalles"),
        content: Text(
            "estamos preparando su pedido , le notificaremos una vez este listo  "),
        isActive: _index == 2,
        state: _index >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text("entrega"),
        content: Column(
          children: [
            Text("Personal asignado :"),
            //_ficha_domicilios(),
            //fecha de entrega
          ],
        ),
        isActive: _index == 3,
        state: _index >= 3 ? StepState.complete : StepState.disabled,
      ),
    ];

    return Container(
      margin: EdgeInsets.only(top: 10),
      //color: PURPLE,
      child: Stepper(
        //physics: ClampingScrollPhysics(), //scroll
        physics: ClampingScrollPhysics(),
        steps: step_list, //lista
        type: StepperType.horizontal,
        currentStep: this._index, //valor
        onStepTapped: (index) {
          setState(() {
            _index = index;
          });
        },
        /*
        onStepCancel: null,
        onStepContinue: () {
          if (_index < step_list.length - 1) {
            _index = _index + 1;
          } else {
            _index = 0;
            //current_step = 0;
          }
        },*/
      ),
    );
  }

  Widget _seleccionar_categorias(BuildContext context) {
    // materiaslista_soloinicio.clear();
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '1',
        materia: "Peluqueria",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://cdn.euroinnova.edu.es/img/subidasEditor/fotolia_61427847_subscription_monthly_m-1576654671.webp",
        fotoUrlFondo:
            "https://cdn.euroinnova.edu.es/img/subidasEditor/fotolia_61427847_subscription_monthly_m-1576654671.webp",
        color: ""));
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '2',
        materia: "Manucure",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://tu-belleza.com/wp-content/uploads/2019/10/esmalte-permanente.jpg",
        fotoUrlFondo:
            "https://tu-belleza.com/wp-content/uploads/2019/10/esmalte-permanente.jpg",
        color: ""));
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '3',
        materia: "Barberia",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        fotoUrlFondo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        color: ""));

    materiaslista_soloinicio.add(new Materias(
        idMaterias: '4',
        materia: "Color Dama ",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPf7HZej-m7S4uW3-wkXi9_oMJet88K27f9Q&usqp=CAU",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPf7HZej-m7S4uW3-wkXi9_oMJet88K27f9Q&usqp=CAU",
        color: ""));
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '5',
        materia: "Color Hombre",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://i0.wp.com/modaellos.com/wp-content/uploads/2020/05/colores-para-el-cabello-hombre-ceniza-undercut.png",
        fotoUrlFondo:
            "https://i0.wp.com/modaellos.com/wp-content/uploads/2020/05/colores-para-el-cabello-hombre-ceniza-undercut.png",
        color: ""));
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '5',
        materia: "SPA",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuIazLon_qYfMj0hJvAUZgj7cuQOHP9GYBDA&usqp=CAU",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuIazLon_qYfMj0hJvAUZgj7cuQOHP9GYBDA&usqp=CAU",
        color: ""));

    //return Movie_horizontal(materias_list: materiaslista_soloinicio);
    return Card_swipeer(materiaslist: materiaslista_soloinicio); //clase
  }

//5  worker
  Widget _ficha_domicilios(Orders order_ficha_worker) {
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
                        'assets/jar-loading.gif'), //img mientras carga
                    fit: BoxFit.cover,
                    height: 250, //ancho posiible
                    width: double.infinity,
                  ),
                ),
                Text(""),
                Center(child: Text(order_ficha_worker.nombreworker)),
                Center(child: Text("cargo :Profesional")),
                Center(child: Text("Puntaje")),
                /*Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.menu_book_outlined),
                      Text("  ver lista de pedido ")
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.directions),
                      Text("  ver datos del cliente ")
                    ],
                  ),
                ),*/

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

  //6. completar servicio y guardar en mi backend
  Future<void> _completar_delivery(
      String keyUid,
      String nombreCliente,
      String keyworker,
      String nombreworker,
      String buyOrder,
      String totalString) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('http://salonhousev2.herokuapp.com/servicio_completo/123'));
    request.body = json.encode({
      "uid_cliente": keyUid,
      "nombre_cliente": nombreCliente,
      "uid_worker": keyworker,
      "nombre_worker": nombreworker,
      "buyOrder": buyOrder,
      "amount": totalString
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // complete
      try {
        _panel_steper_informar_cliente(buyOrder, keyUid);
        _panel_steper_estados_pedido_recibido(buyOrder, 4, keyUid);
      } catch (e) {}
    } else {
      print(response.reasonPhrase);
    }
  }

  //6.1
  Future _panel_steper_informar_cliente(String buyorder, String keyuid) async {
    int i = 4;
    var busqueda2 = FirebaseFirestore.instance
        .collection('Orders_users')
        .doc("usuarios")
        .collection('keyUid')
        .doc(buyorder);
    //  .orderBy('buyOrder', descending: true)
    //.snapshots();

    await busqueda2.update({
      // 'status': 'Complete',
      'id_pagocomletado': i,
    }).then((value) => () {
          print("actualizado en el usuarios");
          // _status_admin_autorizado(buyorder, i, keyuid);
          // print("$estadodepago");
        }); //1. pendiente,2pagado,3preparando,enviando
  }

  //6.2
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

          // print("$estadodepago");
        }); //1. pendiente,2pagado,3preparando,enviando
  }

  ///workert------------------------------
/////aqui ponemos al worker en lista de espera perfecto 100%
  _lista_worker_on_turno() async {
    String timestamp1 = DateTime.now().millisecondsSinceEpoch.toString();

    var turno = Turno(
        timestamp: timestamp1,
        uid: _pref_user.token,
        fotoString: _pref_user.foto,
        tel: _pref_user.telefono,
        profesion: "Profesional",
        disponible: false,
        nombre: _pref_user.nombre,
        notifi: _pref_user.token_notifi);

    var busqueda2 = FirebaseFirestore.instance
        .collection('Users')
        .doc("workers")
        .collection('turnos')
        .doc(_pref_user.token)
        .set(turno.toJson());
    //  .collection("turnos");

    //.collection(key_cliente)
    //.doc(buyorder);
    //  .orderBy('buyOrder', descending: true)
    //.snapshots();

    //busqueda2.add(turno.toJson());
  }
}
