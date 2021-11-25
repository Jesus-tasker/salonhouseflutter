import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:salonhouse/src/bloc/provider_bloc.dart';
import 'package:salonhouse/src/maps/maps_activity.dart';
import 'package:salonhouse/src/models/materias_elegir.dart';

import 'package:salonhouse/src/pagues/administradion/panelv_Admins.dart';

import 'package:salonhouse/src/pagues/login/gogogle_sing_provider.dart';
import 'package:salonhouse/src/pagues/login/login_page.dart';
import 'package:salonhouse/src/pagues/login/perfil_usuario.dart';
import 'package:salonhouse/src/pagues/login/registro%20usuario.dart';
import 'package:salonhouse/src/pagues/navegador/home.dart';
import 'package:salonhouse/src/pagues/navegador/navegador_buton.dart';
import 'package:salonhouse/src/pagues/navegador/perfil_usuario_navi.dart';
import 'package:salonhouse/src/preferencias_usuario/preferences_user.dart';
import 'package:salonhouse/src/providers/navegationbar/ui_provider.dart';
import 'package:salonhouse/src/services_push/push_notification.dart';
import 'package:salonhouse/src/youtube%20mvc/Youtube_home.dart';
import 'package:salonhouse/src/youtube%20mvc/videolist_v1.dart';

void main() async {
  //las giguientes lineas son para usar preferencias

  WidgetsFlutterBinding
      .ensureInitialized(); //esto dice que se llame a todos estos await antes que se dibuje el widget
  // await Firebase.initializeApp(); //ya inicializado en push notificaciones
  //await Firebase.initializeApp(); //firebase core y cloud
  await PushNotificationService.inicialiceapp(); //inicializar (video 271)
  //await
  final pref = new PreferenciasUsuario();

  await pref.initPrefs();
  runApp(MyApp2());
}

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  final GlobalKey<NavigatorState> navegador_key =
      new GlobalKey<NavigatorState>(); ////4.01 para notificaicones
  final GlobalKey<ScaffoldMessengerState> messengerkey =
      new GlobalKey<ScaffoldMessengerState>(); ////4.01 para notificaicones

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //-notificiaciones:
    PushNotificationService.messagestream.listen((mensaje) {
      //https://www.udemy.com/course/flutter-ios-android-fernando-herrera/learn/lecture/14951478#questions
      print("myapp $mensaje"); //titulo de la notificacion
      //- 4.0.1 pasar a otra pantalla  y pasarle los paramteros de la data  //se agrega navigator key  y scafold
      final snack1 = SnackBar(content: Text(mensaje));
      messengerkey.currentState?.showSnackBar(
          snack1); //muestra el mesnaje que de que lelgo algo abajo muy bonito
      //4.0.2 parar a una pantalla en especial
      //validar el tipo d enotificacion que entra
      navegador_key.currentState?.pushNamed("perfil", arguments: mensaje);

      //4.0.2 usa este codigo para recibir los argumentos en donde quieras que te lleve la notificiacion
      //final String arguments=ModalRoute.of(context)?Settings.arguments ?? "nodata";
    });
  }

  @override
  Widget build(BuildContext context) {
    final pref = new PreferenciasUsuario();
    // print(pref.token); //imprime el tokken cuando se obtiene
    String rutainicial = 'login';
    if (pref.token != null && pref.token != "") {
      // print(pref.token);
      rutainicial = 'navegador';
    }

    return /*Provider(
      create: (BuildContext context) {},
      child: */
        Provider_bloc(
      child: MultiProvider(
        //requiere del apquete provider 4.0.4

        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => new Ui_provider(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => new GoogleSingInProvider(),
          )
        ],

        ////

        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Salon House',
          initialRoute: rutainicial, //rutainicial, //
          navigatorKey: navegador_key, //para navegar entre notificaicones
          scaffoldMessengerKey: messengerkey, //para mostrar snacks ..
          routes: {
            //login
            'login': (BuildContext context) => LoginPage(),
            'registro': (BuildContext context) => RegistroPague(),
            'perfil_user': (BuildContext context) => Perfil_Usuario(),

            //basicas

            'navegador': (context) => Navegador_button(),
            'perfil': (context) => Perfil_Usuario_navi(),
            'home': (context) => Home(), //home}

            ///pagos
            'panel': (BuildContext context) => Panel_Admin(),
            //maps
            'map1': (BuildContext context) => MapActivity(),
            //youtube
            //  'youtube': (BuildContext context) =>YoutubePlayerDemoApp(), //video solo personal
            'youtube2': (BuildContext context) => VideoList(), //lista de videos
            'youtube_home': (BuildContext context) => Youtube_Home(),
            // 'pagar_webpay': (context) => Webpay_pagarV4( ),

            //comprasñ
            //'compras': (context) => Compras_carrito(), //home}

            // 'home': (BuildContext context) => HomePage(),
            // 'producto': (BuildContext context) => Productos_pague(),
          },
          //theme: ThemeData.dark(), //temas predefinidos
          theme: ThemeData(
              primaryColor: Colors.purple,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepPurple)), //temas predefinidos
        ),

        //),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);

    return Provider_bloc(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Salon House',
        initialRoute: 'login',
        routes: {
          //login
          'login': (BuildContext context) => LoginPage(),
          'registro': (BuildContext context) => RegistroPague(),

          //basicas
          'navegador': (context) => Navegador_button(),
          'perfil': (context) => Perfil_Usuario_navi(),
          'home': (context) => Home(), //home
          'panel': (BuildContext context) => Panel_Admin(),

          //'producto': (BuildContext context) => ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
