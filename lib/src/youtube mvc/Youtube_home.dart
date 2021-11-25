import 'package:flutter/material.dart';
import 'package:salonhouse/src/constantes/constantes.dart';

import 'package:salonhouse/src/wigetts/card_swiper_.dart';
import 'package:salonhouse/src/wigetts/movies_horizontal.dart';
import 'package:salonhouse/src/models/materias_elegir.dart';
import 'package:salonhouse/src/youtube%20mvc/youtube_v1.dart';

class Youtube_Home extends StatefulWidget {
  // ignore: deprecated_member_use
  @override
  _Youtube_HomeState createState() => _Youtube_HomeState();
}

class _Youtube_HomeState extends State<Youtube_Home> {
  String _seleccionar_categoriaprincipal = "";

  // List<Materias> _Materiaslist1_seleccionar = []; //principal 1

  List<Materias> _materiaslista_soloinicio = []; //
  List<Materias> _materiaslist1_productos = []; //swipe de tarjetas

  //state
  String selecstate = "";

  final _pagueController = new PageController(
    //saber cuando el usuario esta enultima posisicon
    initialPage: 1, //pagina de inicio
    viewportFraction: 0.3, //cantidad de imagenes a mostrar en la pantalla);
  );

  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    _cargar_listas_opciones(); //1. llenamos las casillas de informacion a mostrar
    _cargar_lista_productos_grind();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TEndencias ',
      home: Scaffold(
        //  appBar:appbar_info_user(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: ListView(
            scrollDirection: Axis.vertical,
            //mainAxisAlignment: MainAxisAlignment
            //  .spaceAround, //psrar espacios de todos lods objetos dibujados
            children: <Widget>[
              Text('Peluqeuria '),
              Container(
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
                                      image: NetworkImage(
                                          _materiaslista_soloinicio[i]
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
                                      _mostrarfulldialogvideo(context, 1,
                                          _materiaslista_soloinicio[i]);
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
                                          _mostrarfulldialogvideo(context, 1,
                                              _materiaslista_soloinicio[i]);
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

                          _seleccionar_busqueda(
                              _seleccionar_categoriaprincipal);

                          _mostrarfulldialogvideo(
                              context, 1, _materiaslista_soloinicio[i]);

                          //setState();
                        },
                      );
                    },
                    //children: _tarjetas(context), //PageView.builder
                  )),
              //_seleccionar_categorias(context),
              Text('Productos '),
              //servicios grind:

              _cargargrindviewopciones(context),

              //  _seleccionar_categorias(context),
              Text('Promociones'),
              // _simpleswipe(),
            ],
          ),
        ),
      ),
    );
  }

//1
  void _seleccionar_busqueda(String newValue) {
    //debe ser lalamado dentro de la clase o no sobreescribe es lo qeu entiendo
    setState(() {
      selecstate = newValue;
      print(selecstate + "   selected");

      _seleccionar_categoriaprincipal = selecstate;
    });
  }

  //2.1 cargar lista dde materiales para elinicio
  _cargar_listas_opciones() {
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '1',
        materia: Constantes().servicio1_Peluqueria_Dama,
        descripcion: "pelu dama",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://cdn.euroinnova.edu.es/img/subidasEditor/fotolia_61427847_subscription_monthly_m-1576654671.webp",
        fotoUrlFondo:
            "https://cdn.euroinnova.edu.es/img/subidasEditor/fotolia_61427847_subscription_monthly_m-1576654671.webp",
        color: ""));
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '2',
        materia: Constantes().servicio1_Unas,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://tu-belleza.com/wp-content/uploads/2019/10/esmalte-permanente.jpg",
        fotoUrlFondo:
            "https://tu-belleza.com/wp-content/uploads/2019/10/esmalte-permanente.jpg",
        color: ""));
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '3',
        materia: Constantes().servicio1_Peluqueria_hombre,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        fotoUrlFondo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        color: ""));

    _materiaslista_soloinicio.add(new Materias(
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
    _materiaslista_soloinicio.add(new Materias(
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
    _materiaslista_soloinicio.add(new Materias(
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

//2.2 cargar lista para el grind
  _cargar_lista_productos_grind() {
    _materiaslist1_productos.add(new Materias(
        idMaterias: '10',
        materia: "mi cabello",
        descripcion: "Productos  capilares dama",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhkKCv6l9EYsJj1q5-6glMTx1tcKTNHztlYg&usqp=CAU",
        fotoUrlFondo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhkKCv6l9EYsJj1q5-6glMTx1tcKTNHztlYg&usqp=CAU",
        color: ""));
    _materiaslist1_productos.add(new Materias(
        idMaterias: '11',
        materia: "Cuidada tu piel",
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
        materia: "Productos barber",
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        fotoUrlFondo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        color: ""));

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

//no lo uso
  Widget _seleccionar_categorias(BuildContext context) {
    // materiaslista_soloinicio.clear();
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '1',
        materia: Constantes().servicio1_Peluqueria_Dama,
        descripcion: "pelu dama ",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://cdn.euroinnova.edu.es/img/subidasEditor/fotolia_61427847_subscription_monthly_m-1576654671.webp",
        fotoUrlFondo:
            "https://cdn.euroinnova.edu.es/img/subidasEditor/fotolia_61427847_subscription_monthly_m-1576654671.webp",
        color: ""));
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '2',
        materia: Constantes().servicio1_Unas,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo:
            "https://tu-belleza.com/wp-content/uploads/2019/10/esmalte-permanente.jpg",
        fotoUrlFondo:
            "https://tu-belleza.com/wp-content/uploads/2019/10/esmalte-permanente.jpg",
        color: ""));
    _materiaslista_soloinicio.add(new Materias(
        idMaterias: '3',
        materia: Constantes().servicio1_Peluqueria_hombre,
        descripcion: "crea juegos con unity y c#",
        duracion: "5 horas",
        valor: 20,
        disponible: true,
        fotoUrlLogo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        fotoUrlFondo: "https://www.3claveles.com/img/cms/barberia2.jpg",
        color: ""));

    _materiaslista_soloinicio.add(new Materias(
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
    _materiaslista_soloinicio.add(new Materias(
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
    _materiaslista_soloinicio.add(new Materias(
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

    return Movie_horizontal(materias_list: _materiaslista_soloinicio);
  }

  //3 cargar grind view para opciones de video
  _cargargrindviewopciones(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;

    final double itemHeight = (_screensize.height - kToolbarHeight - 24) / 2;
    final double itemWidth = _screensize.width / 2;
    final double altov2 = _screensize.height * 0.6;

    return GridView.count(
      crossAxisCount: 3,
      scrollDirection: Axis.vertical,
      childAspectRatio: (itemWidth / altov2), // (itemWidth / 370),
      mainAxisSpacing: 2.0, //espacios  arriba y abajo
      crossAxisSpacing: 3.0, //espacio  laterales
      shrinkWrap: true,
      physics: ScrollPhysics(),
      //controller: _pagueController,
      children: _materiaslist1_productos.map((document) {
        // print('Stream!!!!!!!!!!!!!!!!!!');
        //7 print(document['nombre']);
        final tarjeta = Card(child: Text(document.materia.toString()));
        final _screensize = MediaQuery.of(context).size;

        final tarjeta2_productos = Container(
          // width: _screensize.height * 0.4,
          // height: double.maxFinite, // _screensize.height * 0.4,
          //  margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
              Hero(
                tag: document
                    .materia, //cambiamos el id unico para que reciba datos
                child: Stack(children: <Widget>[
                  //SLACK
                  ClipRRect(
                      //wiget circular
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        //IMAGEN
                        image: NetworkImage(document
                            .getposterimage()), //cargar imgane existente
                        placeholder: AssetImage(
                            'assets/jar-loading.gif'), //img mientras carga
                        fit: BoxFit.cover,
                        height: 160, //ancho posiible
                      )),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        _mostrarfulldialogvideo(context, 1, document);
                        //  print(lista_productosen_carrito);
                        //perfil usuario
                        //Navigator.pushReplacementNamed(context, 'perfil_user');
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white38,
                        child: IconButton(
                          icon: Icon(
                            Icons.play_arrow_sharp,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _mostrarfulldialogvideo(context, 1, document);
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
                  ),
                  /* Container(
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
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
                  ),*/
                ]),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                document.materia,
                overflow: TextOverflow
                    .ellipsis, //cuando el texto no cabe pone puntitos
                style: Theme.of(context).textTheme.caption,
              ),

              //en teoria aqui acabo el primer widget !!!!!
            ],
          ),
        );

        return tarjeta2_productos;
        /*GestureDetector(
              child:tarjeta ,
              onTap: ,
            );*/

        //
      }).toList(),
    );
  }

  //4.01 version con full dialog
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
}
