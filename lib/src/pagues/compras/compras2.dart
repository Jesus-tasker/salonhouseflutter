import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:salonhouse/src/constantes/constantes.dart';
import 'package:salonhouse/src/maps/maps_activity.dart';
import 'package:salonhouse/src/models/materias_elegir.dart';
import 'package:salonhouse/src/models/orders.dart';
import 'package:salonhouse/src/models/productos_carrito_model.dart';
import 'package:salonhouse/src/pagues/compras/datos_carrito.dart';
import 'package:salonhouse/src/pagues/compras/pagarwebpay_v4.dart';
import 'package:salonhouse/src/pagues/navegador/home.dart';
import 'package:salonhouse/src/preferencias_usuario/preferences_user.dart';
import 'package:salonhouse/src/providers/login/provider_perfilusuario.dart';
import 'package:salonhouse/src/utils/utils.dart';

//import 'package:salonhouse/src/wigetts/catalogo_compras_horizontal.dart';
//import 'package:flutter/src/widgets/framework.dart'show BuildContext, State, StatefulWidget, Widget;
//import 'package:table_calendar/table_calendar.dart';

String seleccionar_categoriaprincipal = "";
String selecstate = "";
List<Productoscarrito> lista_productosen_carrito = [];
List<Productoscarrito_order> lista3 = [];
//
final _pref_user = new PreferenciasUsuario(); //shared preferences
//String _keyuid = "";
String _keyuid_preference = "";
String _notifiUid_preferences = "";
String _nombre = "";
String _foto = "";
String _tel_temp = "";
String _direccion_temp = "";
String _fecha_servicio = "";
String _hora_servicio = "";
double _latitud_temp = 0, _longitud_temp = 0;

//lista, total  //pasar a otra pagina y completar ell pago desde esta con los datos del suuario.
class Compras_carrito2 extends StatefulWidget {
  //const Compras_carrito({Key? key,this._categoria_seleccionada_carrito}) : super(key: key);
  //recibe la categoria seleccionada en home , pasa " model.idMaterias"
  final List<Materias> listacompleta;
  Compras_carrito2(this.listacompleta, this._categoria_seleccionada_carrito);
  String _categoria_seleccionada_carrito;

  @override
  _Compras_carrito2State createState() => _Compras_carrito2State();
}

class _Compras_carrito2State extends State<Compras_carrito2> {
//requerido para redibjar el widget creo

  void seleccionar_busqueda(String newValue) async {
    print(newValue);
    //debe ser lalamado dentro de la clase o no sobreescribe es lo qeu entiendo
    setState(() {
      print("chandgue: " + selecstate);

      selecstate = newValue;

      seleccionar_categoriaprincipal = newValue;
    });
  }

  void agregaralcarrito(Productoscarrito producto) {
    //debe ser lalamado dentro de la clase o no sobreescribe es lo qeu entiendo
    setState(() {
      lista_productosen_carrito.add(producto);
      print(producto);
    });
  }

  @override
  Widget build(BuildContext context) {
    _validar_preferencias();
    seleccionar_categoriaprincipal = widget._categoria_seleccionada_carrito;
    if (selecstate == "") {
      selecstate = seleccionar_categoriaprincipal;
    }

    // _guardardatos_Cerbezas();
    //  _guardardatos_Ron();
    //_guardardatos_Aguardientes();
    //  selecstate = widget._categoria_seleccionada_carrito;

    // _obtenerinformacion();

    final _screensize = MediaQuery.of(context).size;
    _pagueController.addListener(() {
      //si lelga al final del scroll cargar pelicuals
      if (_pagueController.position.pixels >=
          _pagueController.position.maxScrollExtent - 100) {
        //print('cargar siguiente pagina ');
        //  siguiente_pagina();
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              _icon_regresar(context, selecstate), //btn y texto selected
              //___

              // _seleccionar_categorias_v2(context, widget.listacompleta,seleccionar_categoriaprincipal),

              Container(
                  height: _screensize.height * 0.2, //usar 20 % de pantalla
                  child: PageView.builder(
                    pageSnapping: false, //no entendi bien esta funcion
                    //similar a l swiper
                    controller: _pagueController,
                    itemCount: widget.listacompleta.length,
                    itemBuilder: (contex, i) {
                      final tarjeta = Container(
                        decoration: BoxDecoration(
                            //  color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 3.0,
                                  offset: Offset(0.0, 5.0),
                                  spreadRadius: 3.0)
                            ]),
                        margin: EdgeInsets.only(right: 15.0),
                        child: Column(
                          children: <Widget>[
                            Hero(
                              tag: widget.listacompleta[i]
                                  .idMaterias, //cambiamos el id unico para que reciba datos
                              child: Stack(children: <Widget>[
                                ClipRRect(
                                  //wiget circular
                                  borderRadius: BorderRadius.circular(20),
                                  child: FadeInImage(
                                      //IMAGEN
                                      image: NetworkImage(widget
                                          .listacompleta[i]
                                          .getbackgroundimage()), //cargar imgane existente
                                      placeholder: AssetImage(
                                          'assets/jar-loading.gif'), //img mientras carga
                                      fit: BoxFit.cover,
                                      height:
                                          100 //_screensize.height *0.2 //100 //160, //ancho posiible
                                      ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.listacompleta[i].materia,
                              overflow: TextOverflow
                                  .ellipsis, //cuando el texto no cabe pone puntitos
                              style: Theme.of(context).textTheme.caption,
                            ),
                            //en teoria aqui acabo el primer widget !!!!!
                          ],
                        ),
                      );

                      return GestureDetector(
                        child: tarjeta,
                        onTap: () {
                          //seleccionar_categoriaprincipal =widget.listacompleta[i].materia;

                          seleccionar_busqueda(widget.listacompleta[i].materia);

                          //setState();
                        },
                      );
                    },
                    //children: _tarjetas(context), //PageView.builder
                  )),
              Container(
                height: 10,
              ),
              _productos_firebase(context, selecstate),

              // _pruebafirestore1_v3(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
            print(lista_productosen_carrito.length);
            int total = 0;
            int val1 = 0;
            for (var i = 0; i < lista_productosen_carrito.length; i++) {
              // print(lista_productosen_carrito[i].toJson()); //completo
              total = total + lista_productosen_carrito[i].precio2Int;
              print(total);
              //  if (i == lista_productosen_carrito.length - 1) {}
            }
            //tratemos con  na lista asi
            _mostraralerta(context, lista_productosen_carrito, total);
            //mostramos un alerta con los datos
          },
          label: const Text('Lista'),
          icon: const Icon(Icons.store),
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }
}

_validar_preferencias() {
  if (_pref_user.token != null && _pref_user.token != "") {
    //keyUID
    // print(pref.token);
    _keyuid_preference = _pref_user.token;
    //user.keyUsuario = _keyuid_preference;
    //  Provider_PerfilUsuario pd = Provider_PerfilUsuario();
    //user = pd.recuperarusuario1(keyuid_preference, context);
    //pd.recuperarusuario1(keyuid_preference, context);

  }
  if (_pref_user.token_notifi != null && _pref_user.token_notifi != "") {
    //key notifi
    // print(pref.token);
    _notifiUid_preferences = _pref_user.token_notifi;
    //  user.notifiUid = _notifiUid_preferences;
  }
  if (_pref_user.nombre != null && _pref_user.nombre != "") {
    _nombre = _pref_user.nombre;
    print(_nombre);
    // user.usuarioNombre = _nombre;
    //_traerdatosfirebase(keyuid_preference, context);
  }

  if (_pref_user.foto != null && _pref_user.foto != "") {
    _foto = _pref_user.foto;
    //   user.fotodePerfilUri = _foto; //esta linea parece causar problemas

  }
  if (_pref_user.telefono != null && _pref_user.telefono != "") {
    _tel_temp = _pref_user.telefono;
  }
  if (_pref_user.direccion != null && _pref_user.direccion != "") {
    _direccion_temp = _pref_user.direccion;
  }
  if (_pref_user.latitud != null && _pref_user.latitud != "") {
    _latitud_temp = _pref_user.latitud;
  }
  if (_pref_user.longitud != null && _pref_user.longitud != "") {
    _longitud_temp = _pref_user.longitud;
  }
}

//visualizamos el carrito antes de pagar
_mostraralerta(BuildContext context,
    List<Productoscarrito> lista_prodcut_micarrito, int total_int) {
  int unidades = lista_prodcut_micarrito.length;

  final _screensize = MediaQuery.of(context).size;
  print("165 mostrar alerta-------------");
  print(lista_prodcut_micarrito[0].nombre);

  final double itemHeight = (_screensize.height - kToolbarHeight - 24) / 2;
  final double itemWidth = _screensize.width / 2;
  final double altov2 = _screensize.height * 0.7;
  return showDialog(
      context: context,
      builder: (context) {
        //aqui bien

        return Container(
          child: AlertDialog(
            title: Text('lista'),
            content: Container(
              width: double.maxFinite,
              height: double.infinity,
              child: ListView(
                children: <Widget>[
                  Text('cantidad:  $unidades'),
                  Text('Total: $total_int'),
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
                    children: lista_prodcut_micarrito.map((document) {
                      print('Stream contaienr2!!!!!!!!!!!!!!!!!!');
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
                                      String elimina = document.nombre;
                                      print('eliminar de la lsita $elimina');
                                      for (var i = 0;
                                          i < lista_productosen_carrito.length;
                                          i++) {
                                        if (lista_productosen_carrito[i]
                                                .nombre ==
                                            elimina) {
                                          lista_prodcut_micarrito
                                              .remove(document);
                                          lista_productosen_carrito
                                              .remove(document);

                                          Navigator.pop(context);
                                          // mostrardialogbuttonshet(context, elimina);
                                        }
                                      }
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

                      return tarjeta2;
                    }).toList(),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('cancelar')),
              FlatButton(
                  child: Text('Continuar'),
                  onPressed: () {
                    //primero pondremos la fecha
                    _opciones_fechayhora(
                        context, total_int, lista_prodcut_micarrito);

                    //falta mostrar la ubicaicon del servicio
                    /* _seleccionar_direccion_domicilio(
                        context, total_int, lista_prodcut_micarrito);*/

                    //_mostraropciones_de_pago(context, total_int, lista_prodcut_micarrito);
                  })
            ],
          ),
        );
      });
}

//3.0.01 el usuario selecciona fecha y hora  de la entrega de su servicio
_opciones_fechayhora(BuildContext context, int total_int,
    List<Productoscarrito> lista_prodcut_micarrito) {
  if (_hora_servicio == "null" || _hora_servicio == "") {
    _hora_servicio = "Hora";
  }
  if (_fecha_servicio == "null" || _fecha_servicio == "") {
    _fecha_servicio = "Fecha";
  }
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('1. Fecha y hora  '),
          content: Text("Horario autorizado de 8 am a 18 pm"),
          actions: <Widget>[
            Center(
              child: CircleAvatar(
                child: Icon(Icons.timeline),
              ),
            ),

            Center(child: Text("Fecha servicio")),

            Container(
                width: double.infinity,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    disabledColor: Colors.amber,
                    child: Text(_fecha_servicio),
                    splashColor: Colors.amber,
                    color: Colors.orange[200],
                    onPressed: () {
                      //FECha
                      _selectDate(context, total_int, lista_prodcut_micarrito);
                    })),
            Container(
                padding: EdgeInsets.only(top: 20),
                child: Center(child: Text("Seleccionar hora "))),
            //new direccion escrita
            Container(
                width: double.infinity,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    disabledColor: Colors.green[200],
                    child: Text(_hora_servicio),
                    splashColor: Colors.amber,
                    color: Colors.orange[200],
                    onPressed: () {
                      //return  MapActivity();
                      // Navigator.pushNamed(context, "map1");
                      //HORA
                      _selectTime(context, total_int, lista_prodcut_micarrito);
                    })),
            Container(
                width: double.infinity,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    disabledColor: Colors.amber,
                    child: Text("Confirmar "),
                    splashColor: Colors.amber,
                    color: Colors.green[200],
                    onPressed: () {
                      if (_fecha_servicio == "" ||
                          _hora_servicio == "" && _fecha_servicio != "Fecha" ||
                          _hora_servicio == "Hora") {
                        mostraralerta(context, "selecciona fecha y hora ");
                      } else {
                        _seleccionar_direccion_domicilio(
                            context, total_int, lista_prodcut_micarrito);
                      }
                    })),

            //FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('ok'))
          ],
        );
      });
}

//3.0.2-2 selec fecha de servicio
DateTime selectedDate = DateTime.now();
Future<Null> _selectDate(BuildContext context, int total_int,
    List<Productoscarrito> lista_prodcut_micarrito) async {
  final DateTime? picked = await showDatePicker(
          //builder:(contex,)
          context: context,
          initialDate: selectedDate,
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030))
      //builder:

      /* builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                    primary: Colors.deepPurple,
                    onPrimary: Colors.white,
                    surface: Colors.pink,
                    onSurface: Colors.yellow,
                    ),
                dialogBackgroundColor:Colors.blue[900],
              ),
              child: child,
            );
          },*/
      ;

  if (picked != null) selectedDate = picked;

  //  _dateController.text = DateFormat.yMd().format(selectedDate);

  _fecha_servicio = selectedDate.day.toString() +
      " /" +
      selectedDate.month.toString() +
      " /" +
      selectedDate.year.toString(); //DateFormat.yMd().format(selectedDate);
  _opciones_fechayhora(context, total_int, lista_prodcut_micarrito);
  // "nuevahora "; //DateFormat.yMd().format(selectedDate);// selectedDate.day.toString();
  print(_fecha_servicio);
  _setState(() {
    _fecha_servicio = selectedDate.day.toString();
  });
}

void _setState(Null Function() param0) {}
//3.0.2-2 selec hora
Future<Null> _selectTime(BuildContext context, int total_int,
    List<Productoscarrito> lista_prodcut_micarrito) async {
  TimeOfDay selectedTime = TimeOfDay(hour: 09, minute: 00);

  // DateTime selectedDate = DateTime.now();
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: selectedTime,
  );
  if (picked != null) selectedTime = picked;
  int _hour = selectedTime.hour.toInt();
  String _minute = selectedTime.minute.toString();
  String tarde = selectedTime.format(context).toString();
  String _time = tarde; //_hour + ' : ' + _minute;
  _hora_servicio = _time;
  if (_hour >= 8 && _hour <= 18) {
    _opciones_fechayhora(context, total_int, lista_prodcut_micarrito);
  } else {
    mostraralerta(context, "fuera del horario laboral, 8 am a 18 pm  ");
  }

  _setState(() {
    _hora_servicio = _time;
    print(_time);
  });
  // _timeController.text = _time;
  /*  _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString(););*/
}

//3.1ubicacion
_seleccionar_direccion_domicilio(BuildContext context, int total_int,
    List<Productoscarrito> lista_prodcut_micarrito) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('2. Direccion entrega '),
          // content: Text(""),
          actions: <Widget>[
            Center(
              child: CircleAvatar(
                child: Icon(Icons.map),
              ),
            ),
            Center(child: Text("opcion 1 : Direccion  perfil ")),

            Container(
                width: double.infinity,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    disabledColor: Colors.amber,
                    child: Text(_direccion_temp),
                    splashColor: Colors.amber,
                    color: Colors.orange[200],
                    onPressed: () {
                      if (_direccion_temp == "" || _direccion_temp == null) {
                        //  mostraralerta(context, "")
                        _mostraralerta_usuarionoregistrado(context,
                            "Hola, debes registrarte para solicitar el pedido !");
                      } else {
                        _mostraropciones_de_pago(
                            context, total_int, lista_prodcut_micarrito);
                      }
                    })),
            Container(
                padding: EdgeInsets.only(top: 20),
                child: Center(child: Text("opcion 2 : Nueva direccion "))),
            //new direccion escrita
            TextFormField(
                // initialValue: user.direccion.toString(), //valor del modelo
                maxLength: 50,
                keyboardType: TextInputType
                    .streetAddress, //que acepte solo datos y especifica que recibe decimales
                decoration: InputDecoration(labelText: 'Direccion'),
                onSaved: (valor) => _direccion_temp = valor!,
                onChanged: (texto) {
                  _direccion_temp = texto; //valor cuando cambia la letra
                },
                validator: (value) {
                  //validamos lo que escribe en el campo
                  if (value!.length < 3) {
                    return 'ingresar direccion completa ';
                  } else {
                    return null;
                  }
                }),

            //nueva lat y long
            Container(
                width: double.infinity,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    disabledColor: Colors.amber,
                    child: Text("maps (required)"),
                    splashColor: Colors.amber,
                    color: Colors.orange[50],
                    onPressed: () {
                      _mostrar_fulldialog_mapas(context);
                      //return  MapActivity();
                      // Navigator.pushNamed(context, "map1");
                    })),
            Container(
                width: double.infinity,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    disabledColor: Colors.amber,
                    child: Text("Confirmar opcion 2"),
                    splashColor: Colors.amber,
                    color: Colors.amber[300],
                    onPressed: () {
                      if (_direccion_temp != 0 && _longitud_temp != 0) {
                        _mostraropciones_de_pago(
                            context, total_int, lista_prodcut_micarrito);
                      } else {
                        mostraralerta(context,
                            "ingresa y selecciona tu ubicacion actual");
                      }
                    })),

            //FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('ok'))
          ],
        );
      });
}

//3.2 ubicacion neuva
_mostrar_fulldialog_mapas(BuildContext context) {
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
            Expanded(flex: 5, child: SizedBox.expand(child: MapActivity())
                // FlutterLogo()), //aqui mostraba el logo de flutter
                ),
            Expanded(
              flex: 1,
              child: SizedBox.expand(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'confirmar ',
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

//3.3 mostrar dialogo cuando no tiene perfil
_mostraralerta_usuarionoregistrado(BuildContext context, String mensaje) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(' informacion incorrecta'),
          content: Text(mensaje),
          actions: <Widget>[
            Container(
              // width: size.width * 0.85,
              // margin: EdgeInsets.symmetric(vertical: 30.0),
              // padding: EdgeInsets.symmetric(vertical: 50.0),
              decoration: BoxDecoration(
                  //  color: Colors.white,
                  borderRadius: BorderRadius.circular(110),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: 3.0)
                  ]),
              child: FittedBox(
                fit: BoxFit.contain,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Color.fromRGBO(50, 20, 200, 0.8),
                  child: CircleAvatar(
                    //   radius: 30,
                    // child: Image.asset('assets/logo1.png'),
                    //backgroundImage:Image.network('https://www.sesametime.com/wp-content/themes/zeus/img/undraw/undraw_delivery_address_03n0.png'), //AssetImage('assets/violetaclaro.png'),
                    child: Image.network(
                        'https://www.sesametime.com/wp-content/themes/zeus/img/undraw/undraw_delivery_address_03n0.png'), //AssetImage('assets/violetaclaro.png'),

                    radius: 99,

                    //  borderColor: Colors.yellow,
                  ),
                ),
              ),
            ),
            FlatButton(
                onPressed: () => Navigator.pushNamed(context, "perfil_user"),
                child: Text('Perfil'))
          ],
        );
      });
}

//pasarelas
_mostraropciones_de_pago(BuildContext context, int total_int,
    List<Productoscarrito> lista_prodcut_alert) {
  print("show dialog pagos");
  print(total_int);
  print(lista_prodcut_alert[0].nombre);
  showDialog(
      context: context,
      builder: (context) {
        final _screensize = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text(' Total :$total_int'),
          content: Container(
            /* decoration: BoxDecoration(
                // color: Colors.yellow,
                //border: Border.all(color: Theme.of(context).accentColor,
            )),*/
            width: double.maxFinite,
            // height: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Fecha: " + _fecha_servicio),
                        Text("Hora: " + _hora_servicio),
                        Text("Direccion: " + _direccion_temp),
                        Text("unidades: " + _direccion_temp),
                      ],
                    ),
                  ),
                ),
                Text(""),

                Text('Webpay'),
                Container(
                  width: double.infinity, // _screensize.height * 0.4,
                  height: _screensize.height * 0.2, //160, //ancho posiible

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      /// aqui
                      print('pagar con transbanck');
                      //enviamos los datos del usuario para el pago
                      // Navigator.pushNamed(context, "pagar_webpay");}
                      //aq ya tngo la lista
                      for (var i = 0; i < lista_prodcut_alert.length; i++) {
                        lista3.add(new Productoscarrito_order(
                            categoriaProducto: "categoriaProducto",
                            codigo: lista_prodcut_alert[i].codigo.toString(),
                            fotoString:
                                lista_prodcut_alert[i].fotoString.toString(),
                            nombre: lista_prodcut_alert[i].nombre.toString(),
                            precio: lista_prodcut_alert[i].precio.toString(),
                            precio2Int:
                                lista_prodcut_alert[i].precio2Int.toInt(),
                            disponible: true,
                            timestampString: "timestampString"));
                      }

                      //lista3 = new JsArray();
                      print("lista v3 carrito a orden");
                      print(lista3[0].nombre);

                      var producjson = JsonEncoder();
                      _pref_user.latitud;
                      _pref_user.longitud;
                      String _fecha_de_solicitado =
                          selectedDate.year.toString() +
                              " / " +
                              selectedDate.month.toString() +
                              " / " +
                              selectedDate.day.toString();

                      Orders ordendecompra_p = new Orders(
                        idPagocomletado: 1, //este usemoslo 1,2,3,4
                        timestamp: timestamp,
                        buyOrder: timestamp,
                        sessionId: '11111', //
                        keyBusqueda: "keyBusqueda",
                        status: "pendiente",
                        keyUid: _keyuid_preference,
                        notifiuidCliente: _notifiUid_preferences,
                        fotografia: _foto,
                        nombreCliente: _nombre,
                        direccion: _direccion_temp,
                        totalString: total_int.toString(),
                        telefono: _tel_temp,
                        fechaReservacion: _fecha_de_solicitado,
                        fechaServicios: _fecha_servicio,
                        horaServicios: _hora_servicio,
                        totalInt: total_int,
                        latitudCliente: _pref_user.latitud,
                        longitudCliente: _pref_user.longitud,
                        nombreworker: "nombreworker",
                        fotoworker: "fotoworker",
                        keyworker: "keyworker",
                        productoscarrito_order: lista3,
                      );
                      // lista productos
                      //lista_productosen_carrito
                      print(ordendecompra_p.buyOrder);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Webpay_pagarV4(ordendecompra_p, total_int)),
                        (r) => false,
                      );
                    },
                    child: ClipRRect(
                      //wiget circular
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                          //IMAGEN
                          image: NetworkImage(
                              'https://www.bsr.cl/wp-content/uploads/2018/12/webpayplus.jpg'),
                          placeholder: AssetImage(
                              'assets/no-image.png'), //img mientras carga
                          fit: BoxFit.fill, //BoxFit.cover,
                          width: double.infinity // _screensize.height * 0.4,
                          // height:_screensize.height * 0.2, //160, //ancho posiible
                          ),
                    ),
                  ),
                ),
                Text(""),
                //efectivo

                Text('Efectivo'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    print('pagar con Efectivo');
                    //guardamos la entreda
                    for (var i = 0; i < lista_prodcut_alert.length; i++) {
                      lista3.add(new Productoscarrito_order(
                          categoriaProducto: "categoriaProducto",
                          codigo: lista_prodcut_alert[i].codigo.toString(),
                          fotoString:
                              lista_prodcut_alert[i].fotoString.toString(),
                          nombre: lista_prodcut_alert[i].nombre.toString(),
                          precio: lista_prodcut_alert[i].precio.toString(),
                          precio2Int: lista_prodcut_alert[i].precio2Int.toInt(),
                          disponible: true,
                          timestampString: "timestampString"));
                    }

                    //lista3 = new JsArray();
                    print("lista v3 carrito a orden");
                    print(lista3[0].nombre);

                    var producjson = JsonEncoder();
                    _pref_user.latitud;
                    _pref_user.longitud;
                    String _fecha_de_solicitado = selectedDate.year.toString() +
                        " / " +
                        selectedDate.month.toString() +
                        " / " +
                        selectedDate.day.toString();

                    Orders ordendecompra_p2 = new Orders(
                      idPagocomletado: 1, //este usemoslo 1,2,3,4
                      timestamp: timestamp,
                      buyOrder: timestamp,
                      sessionId: '11111', //
                      keyBusqueda: "keyBusqueda",
                      status: "pendiente",
                      keyUid: _keyuid_preference,
                      notifiuidCliente: _notifiUid_preferences,
                      fotografia: _foto,
                      nombreCliente: _nombre,
                      direccion: _direccion_temp,
                      totalString: total_int.toString(),
                      telefono: _tel_temp,
                      fechaReservacion: _fecha_de_solicitado,
                      fechaServicios: _fecha_servicio,
                      horaServicios: _hora_servicio,
                      totalInt: total_int,
                      latitudCliente: _pref_user.latitud,
                      longitudCliente: _pref_user.longitud,
                      nombreworker: "nombreworker",
                      fotoworker: "fotoworker",
                      keyworker: "keyworker",
                      productoscarrito_order: lista3,
                    );
                    await Provider_PerfilUsuario()
                        .agregarmicompra(ordendecompra_p2, context);
                    mostrardialogbuttonshetv3_pedidoagendado(context,
                        "pedido reservado , podra ver el seguimiento de su compra en pedidos");
                  },
                  child: Container(
                    width: _screensize.height * 0.4,
                    height: _screensize.height * 0.2, //160, //ancho posiible

                    child: ClipRRect(
                      //wiget circular
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        //IMAGEN
                        image: NetworkImage(
                            'https://i2.wp.com/digitalpolicylaw.com/wp-content/uploads/2019/04/dplnews_efectivo_jb190419.jpg'),
                        placeholder: AssetImage(
                            'assets/no-image.png'), //img mientras carga
                        fit: BoxFit.cover,
                        // width: _screensize.height * 0.4,
                        // height:_screensize.height * 0.2, //160, //ancho posiible
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget _icon_regresar(BuildContext context, String seleccion) {
  return Row(
    children: [
      IconButton(
        alignment: Alignment.topLeft,
        onPressed: () {
          lista_productosen_carrito.clear();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
            (r) => false,
          );
        },
        icon: Icon(Icons.redo_sharp),
      ),
      Text(
        '$seleccion',
        // style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
      ),
    ],
  );
}

//-------------v2-------------//

final _pagueController = new PageController(
  //saber cuando el usuario esta enultima posisicon
  initialPage: 1, //pagina de inicio
  viewportFraction: 0.3, //cantidad de imagenes a mostrar en la pantalla);
);
//tratare de controlar todo el valor de la descarga d einformacion aqui
Widget _seleccionar_categorias_v2(BuildContext context, List<Materias> listacom,
    String id_materia_seleccionada) {
  final _screensize = MediaQuery.of(context).size;

  return Container(
      //usar 20 % de pantalla
      height: _screensize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false, //no entendi bien esta funcion
        //similar a l swiper
        controller: _pagueController,
        itemCount: listacom.length,
        itemBuilder: (contex, i) {
          return _tarjeta_buuilder(
              contex, listacom[i], listacom, id_materia_seleccionada);
        },
        //children: _tarjetas(context), //PageView.builder
      ));
}

Widget _tarjeta_buuilder(BuildContext context, Materias model,
    List<Materias> listacompleta, String seleccion_materia) {
//aqui tratamos de redibujar el widget de arriba
//especificamos el tipo de widget <Carrito_datos>
  final seleccionW =
      context.dependOnInheritedWidgetOfExactType<Carrito_datos>();

//
  model.idMaterias =
      '${model.idMaterias}-poster'; //video 119 para la animacion on hero

  //en teoria funcionaria hacer ambos widgets aqui
  final tarjeta = Container(
    margin: EdgeInsets.only(right: 15.0),
    child: Column(
      children: <Widget>[
        Hero(
          tag: model.idMaterias, //cambiamos el id unico para que reciba datos
          child: Stack(children: <Widget>[
            ClipRRect(
              //wiget circular
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  //IMAGEN
                  image: NetworkImage(
                      model.getbackgroundimage()), //cargar imgane existente
                  placeholder:
                      AssetImage('assets/jar-loading.gif'), //img mientras carga
                  fit: BoxFit.cover,
                  height: 110 //160, //ancho posiible
                  ),
            ),
          ]),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          model.materia,
          overflow:
              TextOverflow.ellipsis, //cuando el texto no cabe pone puntitos
          style: Theme.of(context).textTheme.caption,
        ),
        //en teoria aqui acabo el primer widget !!!!!
      ],
    ),
  );

  //retornaremos la targeta con un gestor para agregar tabulacions  coo presion sobre la tarjeta
  return GestureDetector(
    child: tarjeta,
    onTap: () {
      seleccionar_categoriaprincipal = model.materia;
      print(seleccionar_categoriaprincipal); //funciona me imprime el valor

      //no redibuja el widget
      // seleccionarbusquda(seleccionar_categoriaprincipal);

      //seleccionar_busqueda(model.materia);
      //setState();
    },
  );
}

//carrito de compras firebase -----CARRITO------//
Widget _productos_firebase(
    BuildContext context, String seleccionar_categoriaprincipal) {
  //trae toda la colleccion
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Productos')
          .doc('Catalogo')
          .collection('$seleccionar_categoriaprincipal')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot_data) {
        //si no tinene nada
        if (!snapshot_data.hasData)
          return Container(
              child: Column(
            children: <Widget>[
              Text('buscando '),
              CircularProgressIndicator(),
            ],
          ));

        final _screensize = MediaQuery.of(context).size;

        final double itemHeight =
            (_screensize.height - kToolbarHeight - 24) / 2;
        final double itemWidth = _screensize.width / 2;
        final double altov2 = _screensize.height * 0.6;

        return GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          childAspectRatio: (itemWidth / altov2), // (itemWidth / 370),
          mainAxisSpacing: 5.0, //espacios  arriba y abajo
          crossAxisSpacing: 5.0, //espacio  laterales
          shrinkWrap: true,
          physics: ScrollPhysics(),
          //controller: _pagueController,
          children: snapshot_data.data!.docs.map((document) {
            print('Stream!!!!!!!!!!!!!!!!!!');
            print(document['nombre']);
            // final tarjeta = Card(child: Text(document['nombre']));
            final _screensize = MediaQuery.of(context).size;
            final tarjeta2 = Container(
              // width: _screensize.height * 0.4,
              // height: double.maxFinite, // _screensize.height * 0.4,
              //  margin: EdgeInsets.only(right: 15.0),

              child: Column(
                children: <Widget>[
                  Hero(
                    tag: document[
                        'nombre'], //cambiamos el id unico para que reciba datos
                    child: Stack(children: <Widget>[
                      ClipRRect(
                        //wiget circular
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          //IMAGEN
                          image: NetworkImage(document[
                              'foto_string']), //cargar imgane existente
                          placeholder: AssetImage(
                              'assets/no-image.png'), //img mientras carga
                          fit: BoxFit.cover,
                          width: _screensize.height * 0.3,
                          height:
                              300, //_screensize.height * 0.3 //160, //ancho posiible
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            //
                            print('agregado' + document.data().toString());
                            //show_buttonsheep_util(context, "agregado"); //utils

                            lista_productosen_carrito.add(new Productoscarrito(
                                categoriaProducto:
                                    document['categoria_producto'],
                                codigo: document['codigo'],
                                fotoString: document['foto_string'],
                                nombre: document['nombre'],
                                precio: document['precio'],
                                precio2Int: document['precio2_int'],
                                disponible: document['disponible'],
                                timestampString: timestamp));
                            //
                            print(lista_productosen_carrito.length);
                            String nom = document['nombre'];
                            String valor = document['precio'];

                            showModalBottomSheet(
                              context: context,
                              builder: (context) => GestureDetector(
                                child: Container(
                                  height: 70,
                                  child: Column(
                                    children: [
                                      Text('Agregado :$nom'),
                                      Text('Precio   :$valor'),
                                      Icon(Icons.local_activity_rounded),
                                    ],
                                  ),
                                ),
                                onVerticalDragStart: (_) {},
                              ),
                            );

                            //  print(lista_productosen_carrito);
                            //perfil usuario
                            //Navigator.pushReplacementNamed(context, 'perfil_user');
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://thumbs.dreamstime.com/b/carro-icono-de-oro-compra-ilustraci%C3%B3n-vectorial-del-fondo-part%C3%ADculas-doradas-169142747.jpg'),
                            radius: 25.0,
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
                    document['nombre'],
                    overflow: TextOverflow
                        .ellipsis, //cuando el texto no cabe pone puntitos
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            //este es el iciono de dinero
                            // print(document);
                            //  print(document['nombre']);
                          },
                          icon: Icon(Icons.monetization_on)),
                      Text(
                        document['precio'],
                        overflow: TextOverflow
                            .ellipsis, //cuando el texto no cabe pone puntitos
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Spacer(),
                      Icon(
                        Icons.star_border,
                        color: Colors.yellow,
                      ),
                      Text("5"),
                    ],
                  ),
                  //en teoria aqui acabo el primer widget !!!!!
                ],
              ),
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
}

//no terminado
String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
Future<int> _obtenerinformacion_v2() async {
  var moviesRef = await FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().servicio1_Peluqueria_Dama);

  //

  List<Productoscarrito> listado2;

  moviesRef.get().then((QuerySnapshot querySnapshot) {
    //Productoscarrito productoscarrito = querySnapshot.docs;
    querySnapshot.docs.forEach((doc) {
      //print('snapshops: '); //imporime los snaps que hay pero codificados
      print(doc['nombre']);
      Productoscarrito productoscarrito;
      //productoscarrito =doc.data();
      print(doc.data()); //funciona me imprime el json
      //print(productoscarrito);
//        Productoscarrito.fromJson();
      // print(document.nombre);

      // productoscarrito = doc as Productoscarrito;
      /* Productoscarrito productosv2 = new Productoscarrito(
          categoriaProducto: doc["categoria_Producto"],
          codigo: doc['codigo'],
          fotoString: doc['foto_String'],
          nombre: doc['nombre'],
          precio: doc['precio'],
          precio2Int: doc['precio2_Int'],
          disponible: doc['disponible'],
          timestampString: doc['timestamp_String']);
      // print(productosv2.nombre); //no funciona*/
    });
  });
  /* moviesRef.withConverter<Productoscarrito>(
    fromFirestore: (snapshot, _) => Productoscarrito.fromJson(snapshot.data()!),
    toFirestore: (movie, _) => movie.toJson(),
  );*/

  return 1;
}

//------peluqeuria
void _guardardatos_peluqueriadama() async {
  String pelu = Constantes().servicio1_Peluqueria_Dama;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 100,
      fotoString: "",
      nombre: 'Corte Chasquilla ',
      precio: "5000",
      precio2Int: 5000,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 101,
      fotoString: "",
      nombre: 'Corte Dama ',
      precio: "13000",
      precio2Int: 13000,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 102,
      fotoString: "",
      nombre: 'Brushing',
      precio: "14000",
      precio2Int: 14000,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 103,
      fotoString: "",
      nombre: 'Coletas',
      precio: "14000",
      precio2Int: 14000,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 104,
      fotoString: "",
      nombre: 'Moños',
      precio: "14000",
      precio2Int: 14000,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 105,
      fotoString: "",
      nombre: 'Gala',
      precio: "14000",
      precio2Int: 14000,
      disponible: true,
      timestampString: timestamp));
  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().servicio1_Peluqueria_Dama);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

void _guardardatos_peluqueria_hombre() async {
  String pelu = Constantes().servicio1_Peluqueria_hombre;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 200,
      fotoString: "",
      nombre: 'Barberia',
      precio: "8000",
      precio2Int: 10000,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 201,
      fotoString: "",
      nombre: 'Corte Varon ',
      precio: "12000",
      precio2Int: 12000,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 202,
      fotoString: "",
      nombre: 'Corte+Barba ',
      precio: "18000",
      precio2Int: 18000,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 203,
      fotoString: "",
      nombre: 'Mascarilla negra',
      precio: "14000",
      precio2Int: 14000,
      disponible: true,
      timestampString: timestamp));

  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().servicio1_Peluqueria_hombre);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

//---------Licorera
//
void _guardardatos_Cerbezas() async {
  String pelu = Constantes().servicio1_Peluqueria_hombre;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 200,
      fotoString:
          "https://www.santaritazapatoca.com/wp-content/uploads/2020/11/cerveza-heineken-24.png",
      nombre: 'pack Heineken x24',
      precio: "17990",
      precio2Int: 17990,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 201,
      fotoString:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQh1ZqISAsclCrO76dVFptWNcFomPycGzBb-w&usqp=CAU",
      nombre: 'Pack 24 coronas extra',
      precio: "29990",
      precio2Int: 29990,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 202,
      fotoString:
          "https://www.elcielo.cl/tienda/1509-large_default/cerveza-andes-lata-470cc.jpg",
      nombre: 'Andes X 12  ',
      precio: "9000",
      precio2Int: 21000,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 203,
      fotoString:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3oAGR2Dw4w1HrJqc5Z3evZwN7BK9Rc3sV4A&usqp=CAU",
      nombre: 'budweiserx 12 ',
      precio: "14000",
      precio2Int: 14000,
      disponible: true,
      timestampString: timestamp));

  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().cerbezas);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

void _guardardatos_Ron() async {
  String pelu = Constantes().servicio1_Peluqueria_hombre;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 200,
      fotoString:
          "https://images.jumpseller.com/store/comercial-jp/11431955/ron-viejo-caldas-8-a_os-700cc.jpg?1632449705",
      nombre: 'Ron de caldas ',
      precio: "17990",
      precio2Int: 17990,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 201,
      fotoString:
          "https://plazavea.vteximg.com.br/arquivos/ids/412218-450-450/197281.jpg",
      nombre: 'Ron de Medelllin 750 cc',
      precio: "29990",
      precio2Int: 29990,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 200,
      fotoString:
          "https://images.jumpseller.com/store/comercial-jp/11431955/ron-viejo-caldas-8-a_os-700cc.jpg?1632449705",
      nombre: 'Ron de caldas ',
      precio: "17990",
      precio2Int: 17990,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 201,
      fotoString:
          "https://plazavea.vteximg.com.br/arquivos/ids/412218-450-450/197281.jpg",
      nombre: 'Ron de Medelllin 750 cc',
      precio: "29990",
      precio2Int: 29990,
      disponible: true,
      timestampString: timestamp));

  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().Ron);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

void _guardardatos_Aguardientes() async {
  String pelu = Constantes().servicio1_Peluqueria_hombre;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 200,
      fotoString:
          "https://images.jumpseller.com/store/comercial-jp/11431955/ron-viejo-caldas-8-a_os-700cc.jpg?1632449705",
      nombre: 'AGuardiente Antioqueño sin azucar 2.000ml',
      precio: "17990",
      precio2Int: 17990,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 201,
      fotoString:
          "https://s.cornershopapp.com/product-images/1241390.jpg?versionId=x0VTqtF8Ibyg0JG_JgVwy9ejdDCpLEXa",
      nombre: 'Aguardiente Blanco del valle',
      precio: "1990",
      precio2Int: 19990,
      disponible: true,
      timestampString: timestamp));

  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().Aguardientes);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}
