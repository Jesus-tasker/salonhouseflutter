import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:salonhouse/src/models/orders.dart';

//video 121
//https://www.udemy.com/course/flutter-ios-android-fernando-herrera/learn/lecture/14493204#questions/7741832

//LOGICA DE BUSCAdor appbar
class Data_search_buscador extends SearchDelegate {
//acciones //iconos al principio //resultados //suferencias

  String seleccion_string = '';

  // final Peliculas_Provider peliculas_provider = new Peliculas_Provider();
  final peliculas = [
    'superman 1',
    'superman 2',
    'superman 3',
    'superman 4',
    'spiderman 1',
    'spiderman 2',
    'spiderman 3',
    'capitanameria ',
    'batman vs superman',
    'aquiaman '
  ];
  final peliculas_recientes = [
    'spiderman',
    'batman',
  ];

  //limpia el buscador
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions //ACciones del appbar //icono cancelar o una X
    // throw UnimplementedError();
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // palablra clave de buscar
        },
      ),
    ];
  }

  //retornar anteroior pagina
  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //icono a la izquierda del appbar icono buscador por ejemplo----
    //throw UnimplementedError();
    return
        //retornamos la lista de wigets []
        IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        //boton regresar
        //print('leading icon press');
        close(context, null); //regresaera a la pantalla anterior
      },
    );
  }

  //busca los resultados
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //crea los resultados que vamos a msotrar-------
    // throw UnimplementedError();

    return Center(
        child: Container(
      height: 100,
      width: 100,
      //color: Colors.accents,
      child: (Text(seleccion_string)),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //sugerencias cuando la persona escribe----

    //aqui busca las opciones entre la lista
    if (query.isEmpty) {
      return Container();
    }

    return _productos_firebase(context, query);

    /* FutureBuilder(
      //recibe una lista cuando hace una peticion https
      // future: Future,
      future: null, //peliculas_provider.buscarPelicula(query),
      //initialData: InitialData,
      builder: (BuildContext context,
          AsyncSnapshot<List<Productoscarrito_order>> snapshot) {
        if (snapshot.hasData) {
          final peliculas_snap = snapshot.data; //clase -

          return ListView(
              children: peliculas_snap!.map((peli) {
            return ListTile(
              leading: FadeInImage(
                  image: NetworkImage(peli.getposterimage()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50,
                  fit: BoxFit.contain),
              title: Text(peli.nombre),
              subtitle: Text(peli.categoriaProducto),
              onTap: () {
                close(context, null); //cerrar
                peli.codigo = ''; //este lo enviamos por requisito
                Navigator.pushNamed(context, 'detalle',
                    arguments: peli); //enviamos el bundle (argument)
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );*/
  }

  Widget _productos_firebase(BuildContext context, String querriuse) {
    //trae toda la colleccion

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Productos')
            //.doc('Catalogo')
            //  .collection('$querriuse')
            .where('nombre', arrayContainsAny: [
          '$querriuse[0]',
          '$querriuse[1]'
        ]).snapshots(),
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

                              /*   lista_productosen_carrito.add(new Productoscarrito(
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
                            print(lista_productosen_carrito.length);*/
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

  //ESTA LA CREE EL 01/09/2021
//DEBERIA ser la query en el sanapshop de prpoductos a ver si existe el producto o no

/* //original usando la lista sin la api
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //crea los resultados que vamos a msotrar-------
    // throw UnimplementedError();

    return Center(
        child: Container(
      height: 100,
      width: 100,
      //color: Colors.accents,
      child: (Text(seleccion_string)),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //sugerencias cuando la persona escribe----
    //throw UnimplementedError();

    //aqui busca las opciones entre la lista
    final listasugerida = (query.isEmpty) //si el listado esta vacio
        ? peliculas_recientes //lista de peliculas recientes
        : peliculas.where(//lista donde busca peliculas
            (p1) => p1.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: listasugerida.length,
      itemBuilder: (contex, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listasugerida[i]),
          onTap: () {
            seleccion_string = listasugerida[i];
            showResults(context);
            //print('pulsado ' + listasugerida[i].toString());
          },
        );
      },
    );
  }
  */
}
