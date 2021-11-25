import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salonhouse/src/constantes/constantes.dart';
import 'package:salonhouse/src/models/usuario_model.dart';
import 'package:salonhouse/src/preferencias_usuario/preferences_user.dart';
import 'package:salonhouse/src/utils/productoswella.dart';
import 'package:salonhouse/src/utils/utils_textos.dart';

import 'package:salonhouse/src/wigetts/card_swiper_.dart';
import 'package:salonhouse/src/wigetts/movies_horizontal.dart';
import 'package:salonhouse/src/models/materias_elegir.dart';
import 'package:salonhouse/src/youtube%20mvc/youtube_v1.dart';

class Home extends StatefulWidget {
  // ignore: deprecated_member_use
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Materias> materiaslist1 = [];

  List<Materias> materiaslista_soloinicio = []; //primera fila

  List<Materias> _materiaslist1_productos = []; //segunda
  List<Materias> _materiaslist1_productos_wella_color = [];
  bool localabierto = false;

  var establecimiento = "Cerrrado";

  @override
  Widget build(BuildContext context) {
    //mas rapido guardamos las listas en firebase asi
    //belelza
    // guardardatos_wella_rojo_1_color_brillance();
    //guardardatos_wella_2_naranja_nutri_enrich();
    //guardardatos_wella_3_rosa_blondie(); //cuestion con esta ..
    //--
    //guardardatos_wella_4_rosa_blonde_richard();
    //guardardatos_wella_5_blanco_color_motion();
    // guardardatos_wella_6_fusioncolor();
    // guardardatos_wella_7_oil_refrrection();
    //----
    _cargar_listas_opciones(); //videos player
    _cargar_lista_productos_grind(); //tercera lista
    // _cargar_lista_productos_grind2_licorera();
    _verificarsiestaabiertoelestabblecimiento(); //revisa si esta abiertonn
    var color_tx = Colors.red;
    if (localabierto != false) {
      establecimiento = "Abierto";
      color_tx = Colors.green;
    }

    //
    // _cargar_listaalterna();
    return MaterialApp(
      //  theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        //  appBar:appbar_info_user(),
        body: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            //mainAxisAlignment: MainAxisAlignment
            //  .spaceAround, //psrar espacios de todos lods objetos dibujados
            children: <Widget>[
              Center(
                child: Text(establecimiento,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: 2,
                    style: TextStyle(
                        color: color_tx, decoration: TextDecoration.none)),
              ),
              /* Text('Servicios'),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  color: Colors.grey[100],
                  child: _seleccionar_categorias(context)),*/
              //cambie  los servicios de peluqueria por videos para ver como suar los productos
              //2 productos wella cuidado
              Text('Videos Hazlo en casa '),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  color: Colors.grey[100],
                  child: _listadevideos_hazloencasa(context)),
              Container(
                  padding: EdgeInsets.all(10),
                  child: util_texts_black2_agregattamano(
                      "Linea Profesional cuidado capilar wella ", 1)),
              //Colorista Profesional

              Container(
                  padding: EdgeInsets.only(top: 10),
                  color: Colors.grey[100],
                  child: _categorias_wella()),
              Container(
                  padding: EdgeInsets.all(15),
                  child: util_texts_black2_agregattamano(
                      "Colorista Profesional", 1)),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  color: Colors.grey[100],
                  child: _simpleswipe_productos_wella_peluqueria()),

              //3  UÑAS MAQUINA Y BARBER Y CUIDADO DE LA PIEL
              Container(
                  padding: EdgeInsets.all(15),
                  child: util_texts_black2_agregattamano(
                      "Productos Profesionales", 1)),
              _simpleswipe_productos(), //inicialmos la lista en otro lado
              //4

              Container(
                height: 100,
              ),

              // Text('Promociones'),
              // _simpleswipe_porcentajes(), //aaqui tiene la lista

              /*  Text('Productos destacados '),
              _simpleswipe(),
              Text('Capacitaciones '),
              _simpleswipe(),
              Text('Tendencias'),
              _simpleswipe(),
              Text('top mejroes estilistas'),
              _simpleswipe(),*/
            ],
          ),
        ),
      ),
    );
  }

  _verificarsiestaabiertoelestabblecimiento() async {
    CollectionReference adminref_info =
        FirebaseFirestore.instance.collection('Users');
    var _pref_user = PreferenciasUsuario();

    adminref_info.doc("Admin").get().then((value) {
      var user2 = Usuario.fromdocument(value);
      if (user2.notifiUid != null && user2.notifiUid != "") {
        // print("nestado local ");
        _pref_user.notifi_local_abierto = user2.notifiUid;
        setState(() {
          localabierto = true;
          establecimiento = "Abierto";
        });

        // enviar_nueva_notificacion("Nueva entrega", timestamp, user2.notifiUid);
      }
    });

    //para los admin
  }

  Widget appbar_info_user() {
    return AppBar(
        title: Row(
      children: [
        Text('cliente '),
        FadeInImage(
          //IMAGEN
          image: NetworkImage(
              'https://cdn.alfabetajuega.com/wp-content/uploads/2020/04/one-piece-luffy-wano.jpg?width=1200&aspect_ratio=1200:631'), //cargar imgane existente
          placeholder: AssetImage('assets/no-image.png'), //img mientras carga

          height: 32,
        ),
        Container(
            padding: const EdgeInsets.all(8.0), child: Text('Jesus Montoya 2'))
      ],
    ));
  }

  Widget _seleccionar_categorias(BuildContext context) {
    // materiaslista_soloinicio.clear();
    _cargarlistaspeluqeuria_primerailera();
    // _cargarlistas_Licores1_primerailera(); //licorera
    //return  Movie_horizontal(materias_list: materiaslista_soloinicio); //original
    return Movie_horizontal(materias_list: materiaslista_soloinicio);
  }

  Widget _swipe_tarjetas() {
    return FutureBuilder(
      // future: Peliculas_Provider()
      //  .getEncines(), //llamada http y pbtiene la lista de peliculas
      //// initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        //pasa el esnap chop a una lsita
        //vamos a enviar la data del snapshop
        if (snapshot != null) {
          // return Card_swipeer(materiaslist: snapshot.data); //clase
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        } else {
          // return Container(
          //   height: 400, child: Center(child: CircularProgressIndicator()));

          //retornamos la lsita personalizada
          // ignore: deprecated_member_use

          materiaslist1.add(new Materias(
              idMaterias: 'str',
              materia: "Programacion de videojeugos",
              descripcion: "crea juegos con unity y c#",
              duracion: "5 horas",
              valor: 20,
              disponible: true,
              fotoUrlLogo: "",
              fotoUrlFondo: "",
              color: ""));

          materiaslist1.add(new Materias(
              idMaterias: 'str',
              materia: "Programacion de videojeugos",
              descripcion: "crea juegos con unity y c#",
              duracion: "5 horas",
              valor: 20,
              disponible: true,
              fotoUrlLogo: "",
              fotoUrlFondo: "",
              color: ""));

          materiaslist1.add(new Materias(
              idMaterias: 'str',
              materia: "Programacion de videojeugos",
              descripcion: "crea juegos con unity y c#",
              duracion: "5 horas",
              valor: 20,
              disponible: true,
              fotoUrlLogo: "",
              fotoUrlFondo: "",
              color: ""));
          return Card_swipeer(materiaslist: materiaslist1); //clase

        }
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.book, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('HYdra analitic ',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }

  Widget _simpleswipe_productos() {
    return Card_swipeer(materiaslist: _materiaslist1_productos); //clase
  }

  Widget _simpleswipe_productos_wella_peluqueria() {
    _materiaslist1_productos_wella_color.add(new Materias(
        idMaterias: 'str',
        materia: Constantes().emulsiones_wella,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().emulsiones_wella_foto,
        fotoUrlFondo: Constantes().emulsiones_wella_foto,
        color: ""));
    _materiaslist1_productos_wella_color.add(new Materias(
        idMaterias: 'str',
        materia: Constantes().colorperfec,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().colorprefecfoto,
        fotoUrlFondo: Constantes().colorprefecfoto,
        color: ""));
    _materiaslist1_productos_wella_color.add(new Materias(
        idMaterias: 'str',
        materia: Constantes().colortouch,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().colortouchfoto,
        fotoUrlFondo: Constantes().colortouchfoto,
        color: ""));
    return Card_swipeer(
        materiaslist: _materiaslist1_productos_wella_color); //clase
  }

//---menuwidget videos a reproducir------------------ 320 a 481 aprox 25/11/2021
  List<Materias> _materiaslista_soloinicio = [];
  final _pagueController = new PageController(
    //saber cuando el usuario esta enultima posisicon
    initialPage: 1, //pagina de inicio
    viewportFraction: 0.3, //cantidad de imagenes a mostrar en la pantalla);
  );

  Widget _listadevideos_hazloencasa(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    // _cargar_listas_opciones(); llamada al inicio linea 44 aprox
    return Container(
        height: _screensize.height * 0.2, //usar 20 % de pantalla
        child: PageView.builder(
          pageSnapping: false, //no entendi bien esta funcion
          //similar a l swiper
          controller: _pagueController,
          itemCount: _materiaslista_soloinicio.length,
          itemBuilder: (contex, i) {
            final tarjeta = Container(
              margin: EdgeInsets.only(right: 15.0),
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: _materiaslista_soloinicio[i]
                        .idMaterias, //cambiamos el id unico para que reciba datos
                    child: Stack(children: <Widget>[
                      ClipRRect(
                        //wiget circular
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                            //IMAGEN
                            image: NetworkImage(_materiaslista_soloinicio[i]
                                .getbackgroundimage()), //cargar imgane existente
                            placeholder: AssetImage(
                                'assets/jar-loading.gif'), //img mientras carga
                            fit: BoxFit.cover,
                            height:
                                100 //_screensize.height *0.2 //100 //160, //ancho posiible
                            ),
                      ),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.all(5.0),
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            _mostrarfulldialogvideo(
                                context, 1, _materiaslista_soloinicio[i]);
                            //  print(lista_productosen_carrito);
                            //perfil usuario
                            //Navigator.pushReplacementNamed(context, 'perfil_user');
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white38,
                            child: IconButton(
                              icon: Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                _mostrarfulldialogvideo(
                                    context, 1, _materiaslista_soloinicio[i]);
                              },
                            ),
                          ),
                          /*   CircleAvatar(
                        backgroundImage: Icons.play_circle,
                       //backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/carro-icono-de-oro-compra-ilustraci%C3%B3n-vectorial-del-fondo-part%C3%ADculas-doradas-169142747.jpg'),
                        radius: 25.0,
                        backgroundColor: Colors.red,
                      ),*/
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    _materiaslista_soloinicio[i].materia,
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
                _seleccionar_categoriaprincipal =
                    _materiaslista_soloinicio[i].materia;

                _seleccionar_busqueda(_seleccionar_categoriaprincipal);

                _mostrarfulldialogvideo(
                    context, 1, _materiaslista_soloinicio[i]);

                //setState();
              },
            );
          },
          //children: _tarjetas(context), //PageView.builder
        ));
  }

  String selecstate = "";
  String _seleccionar_categoriaprincipal = "";

  void _seleccionar_busqueda(String newValue) {
    //debe ser lalamado dentro de la clase o no sobreescribe es lo qeu entiendo
    setState(() {
      selecstate = newValue;
      print(selecstate + "   selected");

      _seleccionar_categoriaprincipal = selecstate;
    });
  }

  _mostrarfulldialogvideo(
      BuildContext context, int i, Materias material_selected) {
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
                flex: 9,
                child: SizedBox.expand(
                    child: YoutubePlayerDemoApp(
                        material_selected)), //aqui mostraba el logo de flutter
              ),
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Return',
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

  //--videos instructicvos
  _cargar_listas_opciones() {
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '1',
        materia: "Tintura de Canas",
        descripcion: "Cubre tus canas ",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://botoxcapilar.org/wp-content/uploads/2018/11/joven-con-canas.jpg",
        fotoUrlFondo:
            "https://botoxcapilar.org/wp-content/uploads/2018/11/joven-con-canas.jpg",
        color: ""));
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '2',
        materia: "Cabello Brillante",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://cursodeorganizaciondelhogar.com/wp-content/uploads/2016/02/Ideas-de-tonos-para-cabello-rubio-17.jpg",
        fotoUrlFondo:
            "https://cursodeorganizaciondelhogar.com/wp-content/uploads/2016/02/Ideas-de-tonos-para-cabello-rubio-17.jpg",
        color: ""));
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '3',
        materia: "Rubio Oxidado",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://1.bp.blogspot.com/-itFpR3M43_Q/Vy-h-legqbI/AAAAAAAAOTM/SDQIOE9GasU5UjaVAxZUr9Lzp5P2g48RACLcB/s1600/pelo%2Bamarillo.jpg",
        fotoUrlFondo:
            "https://1.bp.blogspot.com/-itFpR3M43_Q/Vy-h-legqbI/AAAAAAAAOTM/SDQIOE9GasU5UjaVAxZUr9Lzp5P2g48RACLcB/s1600/pelo%2Bamarillo.jpg",
        color: ""));

    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '4',
        materia: "Cabello Quebradizo",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://static-blogs.mujerhoy.com/total-beauty/wp-content/uploads/sites/4/2016/02/Mujer-pelo-fino.jpg",
        fotoUrlFondo:
            "https://static-blogs.mujerhoy.com/total-beauty/wp-content/uploads/sites/4/2016/02/Mujer-pelo-fino.jpg",
        color: ""));
    //
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '5',
        materia: "Cabello Quimicamente Tratado",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://i0.wp.com/modaellos.com/wp-content/uploads/2020/05/colores-para-el-cabello-hombre-ceniza-undercut.png",
        fotoUrlFondo:
            "https://i0.wp.com/modaellos.com/wp-content/uploads/2020/05/colores-para-el-cabello-hombre-ceniza-undercut.png",
        color: ""));
    //
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '5',
        materia: "Cabello Destrozado por Decoloracion",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gettyimages-585214790-1-1548165268.jpg?crop=1xw:1xh;center,top&resize=320:*",
        fotoUrlFondo:
            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gettyimages-585214790-1-1548165268.jpg?crop=1xw:1xh;center,top&resize=320:*",
        color: ""));
  }

  //--
//--productos--------------------------------
  _cargar_listaalterna() {
    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: "Programacion de videojeugos",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl4LxEJ1aR3xyTG1FZSWlza1egGTId1lfz4PXuvArhOPgijB5csdIrwYMKsRPROJXR-B8YEWS5&usqp=CAc",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl4LxEJ1aR3xyTG1FZSWlza1egGTId1lfz4PXuvArhOPgijB5csdIrwYMKsRPROJXR-B8YEWS5&usqp=CAc",
        color: ""));

    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: "Programacion de videojeugos",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: "",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWfhMMhjE4Sk5jo8JCmEicDr2iktodRIeWdQ&usqp=CAU",
        color: ""));

    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: "Programacion de videojeugos",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: "",
        fotoUrlFondo:
            "https://falabella.scene7.com/is/image/Falabella/7303286_4?wid=800&hei=800&qlt=70",
        color: ""));
  }

//--
  _cargarlistaspeluqeuria_primerailera() {
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '1',
        materia: Constantes().servicio1_Peluqueria_Dama,
        descripcion: "pelu dama ",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://botoxcapilar.org/wp-content/uploads/2021/03/balayage-rubio-recien-hecho.jpg",
        fotoUrlFondo:
            "https://botoxcapilar.org/wp-content/uploads/2021/03/balayage-rubio-recien-hecho.jpg",
        color: ""));
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '2',
        materia: Constantes().servicio1_Unas,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://modaellas.com//wp-content/uploads/2020/01/unas-largas-rosas.png",
        fotoUrlFondo:
            "https://modaellas.com//wp-content/uploads/2020/01/unas-largas-rosas.png",
        color: ""));
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '3',
        materia: Constantes().servicio1_Peluqueria_hombre,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        fotoUrlFondo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        color: ""));

    materiaslista_soloinicio.add(new Materias(
        idMaterias: '4',
        materia: Constantes().servicio1_Color_mujer,
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
        materia: Constantes().servicio1_Color_hombre,
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
        materia: Constantes().servicio1_Masajes_reductivos,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuIazLon_qYfMj0hJvAUZgj7cuQOHP9GYBDA&usqp=CAU",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuIazLon_qYfMj0hJvAUZgj7cuQOHP9GYBDA&usqp=CAU",
        color: ""));
  }

  _cargarlistas_Licores1_primerailera() {
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '1',
        materia: Constantes().cerbezas,
        descripcion: "Cerbeza ",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().foto_cerbeza,
        fotoUrlFondo: Constantes().foto_cerbeza,
        color: ""));
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '2',
        materia: Constantes().Ron,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().foto_ron,
        fotoUrlFondo: Constantes().foto_ron,
        color: ""));
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '3',
        materia: Constantes().Aguardientes,
        descripcion: "Aguardiente",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().foto_aguardiente,
        fotoUrlFondo: Constantes().foto_aguardiente,
        color: ""));

    materiaslista_soloinicio.add(new Materias(
        idMaterias: '4',
        materia: Constantes().vinos,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().foto_vinos,
        fotoUrlFondo: Constantes().foto_vinos,
        color: ""));
    materiaslista_soloinicio.add(new Materias(
        idMaterias: '5',
        materia: Constantes().hielo,
        descripcion: "vinos",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().foto_hielos,
        fotoUrlFondo: Constantes().foto_hielos,
        color: ""));
  }

//--
  _cargar_lista_productos_grind() {
    /* _materiaslist1_productos.add(new Materias(
        idMaterias: '10',
        materia: "mi cabello",
        descripcion: "Productos  capilares dama",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://i.pinimg.com/564x/73/a5/ce/73a5ce212918bb3e4cf71bb4d0f15119.jpg",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhkKCv6l9EYsJj1q5-6glMTx1tcKTNHztlYg&usqp=CAU",
        color: ""));*/
    _materiaslist1_productos.add(new Materias(
        idMaterias: '11',
        materia: "Cuidatu Peiel",
        descripcion: "crea ",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROymm5_zHx01_j8hOSavUgaxq8xz4B5IILiJ39EvjJweE83d-gBjEM-YspUJov9ylNHPM&usqp=CAU",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROymm5_zHx01_j8hOSavUgaxq8xz4B5IILiJ39EvjJweE83d-gBjEM-YspUJov9ylNHPM&usqp=CAU",
        color: ""));
    _materiaslist1_productos.add(new Materias(
        idMaterias: '12',
        materia: "Productos Barber",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        fotoUrlFondo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        color: ""));
/*
    _materiaslist1_productos.add(new Materias(
        idMaterias: '13',
        materia: "Tintes y color",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWm3rg8ZE5JmiIRXAVdYbDwdrQeJXhUm1IRXkvPpyRjhJJVaewoVJDWWBNR9m1RpRVO8M&usqp=CAU",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWm3rg8ZE5JmiIRXAVdYbDwdrQeJXhUm1IRXkvPpyRjhJJVaewoVJDWWBNR9m1RpRVO8M&usqp=CAU",
        color: ""));
    */
    _materiaslist1_productos.add(new Materias(
        idMaterias: '5',
        materia: "Maquinas",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC7W1Hr4ylvBkxBmGxWhIL-mwR4Ytr2gsbaQ&usqp=CAU",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC7W1Hr4ylvBkxBmGxWhIL-mwR4Ytr2gsbaQ&usqp=CAU",
        color: ""));
    _materiaslist1_productos.add(new Materias(
        idMaterias: '5',
        materia: "Uñas y pestañas",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRF467Z0o8Om_8YFe8GsT_1LP93U0nselDNdQ&usqp=CAU",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRF467Z0o8Om_8YFe8GsT_1LP93U0nselDNdQ&usqp=CAU",
        color: ""));
  }

  _cargar_lista_productos_grind2_licorera() {
    _materiaslist1_productos.add(new Materias(
        idMaterias: '10',
        materia: Constantes().cubeton,
        descripcion: "Productos  capilares dama",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().foto_cubeton,
        fotoUrlFondo: Constantes().foto_cubeton,
        color: ""));
    _materiaslist1_productos.add(new Materias(
        idMaterias: '11',
        materia: Constantes().combos_familiares,
        descripcion: "crea ",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().foto_Combos_familiares,
        fotoUrlFondo: Constantes().foto_Combos_familiares,
        color: ""));
    _materiaslist1_productos.add(new Materias(
        idMaterias: '12',
        materia: Constantes().Combo_amigos,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().foto_Combos_amigos,
        fotoUrlFondo: Constantes().foto_Combos_amigos,
        color: ""));

    _materiaslist1_productos.add(new Materias(
        idMaterias: '13',
        materia: Constantes().combo_fiesta,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().foto_Combos_fiesta,
        fotoUrlFondo: Constantes().foto_Combos_fiesta,
        color: ""));
  }

//--

  Widget _simpleswipe_porcentajes() {
    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: "Descuentos 10%",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxqV5eDED4spuOR7HVGo3rCkWj19y72UcWVxddoeIr-I3lFN6z9pvC08Kp6aTQehtgZpg&usqp=CAU",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxqV5eDED4spuOR7HVGo3rCkWj19y72UcWVxddoeIr-I3lFN6z9pvC08Kp6aTQehtgZpg&usqp=CAU",
        color: ""));

    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: "Descuento 20%",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: "",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIlfRktzgjEwDAp-269hGDv9iYpmoOrUOnlkDd2WyCZpzcV4WwNeZbp5t-SokFNX65pOQ&usqp=CAU",
        color: ""));

    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: "Descuento 30%",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: "",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaR_No6X3lRGkRWbn1GoCkwSYkyFH36sRbxrHUillJEHgK-QJcQ4Q4y-I8_vQdFyCvACU&usqp=CAU",
        color: ""));
    return Card_swipeer(materiaslist: materiaslist1); //clase
  }

  Widget _categorias_wella() {
    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: Constantes().red_brillance,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().red_brillance_foto,
        fotoUrlFondo: Constantes().red_brillance_foto,
        color: ""));

    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: Constantes().naranja2_nutri_enrich,
        descripcion: "cabellos ribios y teñidos secos",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().naranja2_nutri_foto,
        fotoUrlFondo: Constantes().naranja2_nutri_foto,
        color: ""));
    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: Constantes().verde3_volumen_boost,
        descripcion: "cabellos ribios y teñidos secos",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().verde3_volumen_boost_foto,
        fotoUrlFondo: Constantes().verde3_volumen_boost_foto,
        color: ""));
    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: Constantes().rosa4_volumen_rosa_blonde,
        descripcion: "cabellos ribios y teñidos secos",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().rosa4_volumen_rosa_blondefoto,
        fotoUrlFondo: Constantes().rosa4_volumen_rosa_blondefoto,
        color: ""));
    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: Constantes().blanco5_color_motion,
        descripcion: "cabellos ribios y teñidos secos",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().blanco5_color_motion_foto,
        fotoUrlFondo: Constantes().blanco5_color_motion_foto,
        color: ""));
    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: Constantes().blanco6_fusioncolor,
        descripcion: "cabellos ribios y teñidos secos",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().blanco6_fusioncolorfoto,
        fotoUrlFondo: Constantes().blanco6_fusioncolorfoto,
        color: ""));
    materiaslist1.add(new Materias(
        idMaterias: 'str',
        materia: Constantes().blanco_7oilreflec,
        descripcion: "cabellos ribios y teñidos secos",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: Constantes().blanco7_aceitefoto,
        fotoUrlFondo: Constantes().blanco7_aceitefoto,
        color: ""));

    return Card_swipeer(materiaslist: materiaslist1); //clase
  }
}
