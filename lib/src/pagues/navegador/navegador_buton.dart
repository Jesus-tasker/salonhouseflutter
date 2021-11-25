import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:salonhouse/src/pagues/administradion/panelv_Admins.dart';
import 'package:salonhouse/src/pagues/login/gogogle_sing_provider.dart';
import 'package:salonhouse/src/pagues/navegador/perfil_usuario_navi.dart';
import 'package:salonhouse/src/pagues/navegador/riders/homerider.dart';
import 'package:salonhouse/src/preferencias_usuario/preferences_user.dart';
import 'package:salonhouse/src/providers/navegationbar/ui_provider.dart';
import 'package:salonhouse/src/utils/utils.dart';
import 'package:salonhouse/src/pagues/navegador/custom_navigator_bar.dart';
import 'package:salonhouse/src/wigetts/search/search_delegate.dart';
import 'package:salonhouse/src/youtube%20mvc/Youtube_home.dart';
import 'package:salonhouse/src/youtube%20mvc/videolist_v1.dart';
import 'package:salonhouse/src/youtube%20mvc/youtube_v1.dart';

import 'home.dart';

class Navegador_button extends StatelessWidget {
  // const Navegador_button({Key key}) : super(key: key);
  final _pref_user = new PreferenciasUsuario(); //shared preferences
  //final _pref_user = new PreferenciasUsuario(); //shared preferences

  String keyuid_preference = "";
  String notifiUid_preferences = "";
  String foto = "";
  String nombre = "";

  @override
  Widget build(BuildContext context) {
    if (_pref_user.token != null && _pref_user.token != "") {
      //keyUID
      // print(pref.token);
      keyuid_preference = _pref_user.token;
      print("navegador:");
      print(keyuid_preference);
    }

    if (_pref_user.nombre != null && _pref_user.nombre != "") {
      //keyUID
      // print(pref.token);
      nombre = _pref_user.nombre;
      print("navegador:");
      print(nombre);
    }
    if (_pref_user.foto != null && _pref_user.foto != "") {
      //keyUID
      // print(pref.token);
      foto = _pref_user.foto;
      print("navegador:");
      print(foto);
    }

    var foto_user = foto;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Licores Chia APP'),
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 10),
              //buscador
              icon: Icon(Icons.search),
              onPressed: () {
                //methodo de slutter
                showSearch(
                  context: context,
                  delegate: Data_search_buscador(), //importamos el buscador
                  //query: 'hola ' //no es necesario pero podemos mandar el query desde l inicio
                );
              },
            ),
            IconButton(
                icon: Icon(Icons.person), // Icon(Icons.menu),
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierColor:
                        Colors.black12.withOpacity(0.6), // Background color
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
                              flex: 9,
                              child: SizedBox.expand(
                                  child: Container(
                                padding: EdgeInsets.all(40),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  child: ListView(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            // width: size.width * 0.85,
                                            // margin: EdgeInsets.symmetric(vertical: 30.0),
                                            // padding: EdgeInsets.symmetric(vertical: 50.0),
                                            decoration: BoxDecoration(
                                                //  color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(110),
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
                                                backgroundColor: Color.fromRGBO(
                                                    50, 20, 200, 0.8),
                                                child: CircleAvatar(
                                                  //   radius: 30,
                                                  // child: Image.asset('assets/logo1.png'),
                                                  backgroundImage:
                                                      NetworkImage(foto_user),
                                                  radius: 97,

                                                  //  borderColor: Colors.yellow,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                              child: Container(
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                  child: Text(
                                                    "$nombre ",
                                                    textScaleFactor: 1,
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      // color: Color.fromRGBO(10, 70, 110, 1),
                                                      fontFamily: 'MyFont',
                                                    ),
                                                  ))),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              child:
                                                  Center(child: cuadrado_qr())),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 10, 5),
                                            width: double.infinity,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0)),
                                              disabledColor: Colors.amber,
                                              child: Text("Ver Perfil"),
                                              splashColor: Colors.amber,
                                              color: Colors.orange[300],
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                    context, 'perfil_user');
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 10, 5),
                                            width: double.infinity,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0)),
                                              disabledColor: Colors.amber[900],
                                              child: Text("¿quienes somos? "),
                                              splashColor: Colors.amber,
                                              color: Colors.orange[300],
                                              onPressed: () {
                                                print(
                                                    "ejecutar accion pendiente para ");
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 10, 5),
                                            width: double.infinity,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0)),
                                              disabledColor: Colors.amber[900],
                                              child:
                                                  Text("trabaja con nosotros "),
                                              splashColor: Colors.amber,
                                              color: Colors.orange[300],
                                              onPressed: () {
                                                print(
                                                    "ejecutar accion pendiente para trabajar y mostrar alguna pagina que guarde info o algo asi  ");
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 10, 5),
                                            width: double.infinity,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0)),
                                              disabledColor: Colors.amber[900],
                                              child: Text("Cerrar Sesion "),
                                              splashColor: Colors.amber,
                                              color: Colors.orange[300],
                                              onPressed: () async {
                                                _pref_user.token = "";
                                                // _pref_user.token_notifi = "";
                                                _pref_user.nombre = "";
                                                _pref_user.foto = "";
                                                _pref_user.direccion = "";
                                                _pref_user.telefono = "";
                                                _pref_user.latitud = 0;
                                                _pref_user.longitud = 0;
                                                //cerrrar cesion
                                                final provider_authgoogle =
                                                    Provider.of<
                                                            GoogleSingInProvider>(
                                                        context,
                                                        listen: false);
                                                provider_authgoogle
                                                    .longout_cerrar();

                                                Navigator.pushReplacementNamed(
                                                    context, 'login');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )), //aqui mostraba el logo de flutter
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox.expand(
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'return',
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
                }),
          ],
        ),
        body: _home_pague_body_cliente(),
        bottomNavigationBar: CustomNavigatorBar_clinete(),
        floatingActionButton: null, //ScanButton(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}

//wiget para cambiar paginacion
class _home_pague_body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obtener el selected menu  opt

    final uiprovider =
        Provider.of<Ui_provider>(context); //seleccion en UIprovider

    final currentidex = uiprovider.selectedMneuopt; //posicion en las paginas

    //cambiar para mostrar la pagina
    switch (currentidex) {
      case 0:
        // print(currentidex);
        return Home();

      case 1:
        //print(currentidex);

        return Perfil_Usuario_navi(); //Direcciones_pagues();

      case 2:
        //print(currentidex);

        return Panel_Admin(); // Youtube_Home(); //VideoList();
      //YoutubePlayerDemoApp(); //Panel_Admin(); //Direcciones_pagues();

      case 3:
        //print(currentidex);

        return Home_riders(); //Direcciones_pagues();

      default:
        return Home();
    }

    //opcion
  }

  //opcion 2

}
//opcion 2

class _home_pague_body_cliente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obtener el selected menu  opt

    final uiprovider =
        Provider.of<Ui_provider>(context); //seleccion en UIprovider

    final currentidex = uiprovider.selectedMneuopt; //posicion en las paginas

    //cambiar para mostrar la pagina
    switch (currentidex) {
      case 0:
        // print(currentidex);
        return Home();

      case 1:
        //print(currentidex);

        return Perfil_Usuario_navi(); //Direcciones_pagues();

      case 2:
        //print(currentidex);

        return Youtube_Home(); //VideoList();
      //YoutubePlayerDemoApp(); //Panel_Admin(); //Direcciones_pagues();

      case 3:
        //print(currentidex);

        return Home_riders(); //Direcciones_pagues();

      default:
        return Home();
    }

    //opcion
  }

  //opcion 2

}
//opcion 2

class Home3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

//widget simple para paginacion
class _HomeState extends State<Home3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }
}
