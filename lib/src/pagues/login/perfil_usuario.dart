import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salonhouse/src/maps/maps_activity.dart';
import 'package:salonhouse/src/models/usuario_model.dart';
import 'package:salonhouse/src/preferencias_usuario/preferences_user.dart';
import 'package:salonhouse/src/providers/login/Usuario_provider.dart';
import 'package:salonhouse/src/providers/login/provider_perfilusuario.dart';
import 'package:salonhouse/src/providers/product_provider/productos_provider.dart';
import 'package:salonhouse/src/utils/utils.dart' as utilsss;

void main() => runApp(Perfil_Usuario());

class Perfil_Usuario extends StatefulWidget {
  //modelo de datos

  @override
  _Perfil_UsuarioState createState() => _Perfil_UsuarioState();
}

class _Perfil_UsuarioState extends State<Perfil_Usuario> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final _pref_user = new PreferenciasUsuario(); //shared preferences
  // print(pref.token); //imprime el tokken cuando se obtiene

  String _keyuid = "";
  String _keyuid_preference = "";
  String _notifiUid_preferences = "";
  String _nombre = "";
  String _foto = "";
  String _tel_temp = "";
  String _direccion_temp = "";
  bool buscando_nueva_foto = false;

  Usuario user = new Usuario(
      keyBusqueda: "aaa",
      keyUsuario: "",
      notifiUid: "",
      calificaion: 3,
      cargo: "cliente",
      fotodePerfilUri:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ5srpTZoAXWINllDurGscx_Pqg_foehqAkQ&usqp=CAU",
      direccion: "victor manuel 1408",
      latitud: 0,
      longitud: 0,
      teleonoUsuario: "",
      usuarioNombre: "");

  //keys
  final fomkey = GlobalKey<
      FormState>(); //key para reconocer el fomrulario y hacer una validacion rapida
  final scafoldkey = GlobalKey<
      ScaffoldState>(); //llave reconocer el scafold y poner objetos dentro de este
  //
  // ProductosBlock productosBlock;

  //
  //Productomodel productomodel = new Productomodel();
  bool btn_pulsado_bool = false;
//imagen

  late File _image_photo;
  // late XFile xfile_foto;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (_pref_user.token != null && _pref_user.token != "") {
      //keyUID
      // print(pref.token);
      _keyuid_preference = _pref_user.token;
      user.keyUsuario = _keyuid_preference;
      Provider_PerfilUsuario pd = Provider_PerfilUsuario();
      //user = pd.recuperarusuario1(keyuid_preference, context);
      //pd.recuperarusuario1(keyuid_preference, context);

    }
    if (_pref_user.token_notifi != null && _pref_user.token_notifi != "") {
      //key notifi
      // print(pref.token);
      _notifiUid_preferences = _pref_user.token_notifi;
      user.notifiUid = _notifiUid_preferences;
    }
    if (_pref_user.nombre != null && _pref_user.nombre != "") {
      _nombre = _pref_user.nombre;
      print(_nombre);
      user.usuarioNombre = _nombre;
      //_traerdatosfirebase(keyuid_preference, context);
    }

    if (_pref_user.foto != null && _pref_user.foto != "") {
      //keyUID
      // print(pref.token);
      if (buscando_nueva_foto == false) {
        _foto = _pref_user.foto;
        user.fotodePerfilUri = _foto; //esta linea parece causar problemas
      }
    }
    if (_pref_user.telefono != null && _pref_user.telefono != "") {
      _tel_temp = _pref_user.telefono;
      //print(nombre);
      user.teleonoUsuario = _tel_temp;
      //_traerdatosfirebase(keyuid_preference, context);
    }
    if (_pref_user.direccion != null && _pref_user.direccion != "") {
      _direccion_temp = _pref_user.direccion;
      //print(nombre);
      user.direccion = _direccion_temp;
      //_traerdatosfirebase(keyuid_preference, context);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perfil Usuario'),
        ),
        body: ListView(
          children: [
            //foto, nombre ,telefono, direccion esxacta. //lat y long foto
            _mostrarfoto(),
            Container(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _iconos_galeriay_camara(),
                  _escribir_nombreUsuario(),
                  _escribir_telefono(),
                  _escribir_direccion_completa(),
                  _mostrarmaps(context),
                  Text(
                      "Recuerda tener activado el gps al momento de solicitar su pedido "),
                  _btn_guardadrinfo(context),

                  //EJEMMPLO DE FIRESTORE obtiene directamente el snapshop

                  // _priebafirestore1(),
                  //
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mostrarfoto() {
    //figet para msotrar el espacio de la imagen hasta qeu eta cambie
    //si el producto tiene una foto
    if (user.fotodePerfilUri != null && user.fotodePerfilUri != "") {
      return Container(
        padding: EdgeInsets.all(30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            //lo envolvemos en un wiget para pasarlo con una animacion de una actividad a otra
            //wiget circular
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                //IMAGEN
                image: NetworkImage(
                    user.fotodePerfilUri), //cargar imgane existente
                placeholder:
                    AssetImage('assets/no-image.png'), //img mientras carga
                fit: BoxFit.cover,
                height: 209 //ancho posiible
                ),
          ),
        ),
      );
    } else {
      if (_image_photo != null) {
        print("carga imagen local");
        var imagen1 = Image.file(
          _image_photo,
          // xfile_foto., //no funciono
          fit: BoxFit.cover,
          height: 300.0,
        );

        /* var r = Container(
          child: Image(image: Image.file(File(filePath))),
        );*/

        /*var imagen2 = Image.file(
          File(xfile_foto.path),
          // xfile_foto., //no funciono
          fit: BoxFit.cover,
          height: 300.0,
        );*/
        //var imagen3 = Image(image: FileImage(File(xfile_foto.path))); //no

        return imagen1;
      }
      return Container(
          height: 300,
          child: Center(
            child: Image.asset(
              'assets/no-image.png',
              fit: BoxFit.cover,
              height: 300.0,
            ),
          ));
    }
  }

  Widget _escribir_nombreUsuario() {
    return TextFormField(
        initialValue: user.usuarioNombre.toString(), //nombre model
        maxLength: 30,
        keyboardType:
            TextInputType.name, //que acepte solo datos y especifica que recibe
        decoration: InputDecoration(labelText: 'Nombre'),
        onChanged: (texto) {
          user.usuarioNombre = texto; //valor cuando cambia la letra
        },
        onSaved: (valor) => user.usuarioNombre = valor!,
        validator: (value) {
          //validamos lo que escribe en el campo
          if (value!.length < 3) {
            return 'ingresar nombre Usuario';
          } else {
            return null;
          }
        });
  }

  Widget _escribir_telefono() {
    return TextFormField(
      initialValue: user.teleonoUsuario.toString(), //valor del modelo
      maxLength: 9,
      keyboardType: TextInputType.numberWithOptions(
          decimal:
              true), //que acepte solo datos y especifica que recibe decimales
      decoration: InputDecoration(labelText: 'Telefono'),
      onSaved: (valor) =>
          user.teleonoUsuario = int.parse(valor!) as String, //guarda el valor
      //valor as double, //aqui guardamos el valor que se utilizo
      onChanged: (texto) {
        user.teleonoUsuario = texto; //valor cuando cambia la letra
      },
      validator: (valor) {
        //utils es una validacion que hice para ver si es un numero
        if (utilsss.isNumeric(valor!)) {
          //si regresa un true es un numero ,
          return null;
        } else {
          return '+56: solo Numero telefonico ';
        }
      },
    );
  }

  Widget _escribir_direccion_completa() {
    return TextFormField(
        initialValue: user.direccion.toString(), //valor del modelo
        maxLength: 50,
        keyboardType: TextInputType
            .streetAddress, //que acepte solo datos y especifica que recibe decimales
        decoration: InputDecoration(labelText: 'Direccion'),
        onSaved: (valor) => user.usuarioNombre = valor!,
        onChanged: (texto) {
          user.direccion = texto; //valor cuando cambia la letra
        },
        validator: (value) {
          //validamos lo que escribe en el campo
          if (value!.length < 3) {
            return 'ingresar direccion completa ';
          } else {
            return null;
          }
        });
  }

  Widget _iconos_galeriay_camara() {
    return Row(
      children: <Widget>[
        IconButton(
            onPressed: () {
              _seleccionarfoto2();
            },
            icon: Icon(Icons.photo_size_select_actual)),
        IconButton(
          onPressed: () {
            _tomarfotografia();
          },
          icon: Icon(Icons.camera_alt_outlined),
        )
      ],
    );
  }

//imagenes seleccion
  _seleccionarfoto2() async {
    _procesarimagen(ImageSource.gallery);
  }

//es casi igual que el anterorio solo cambiamos la direccion de obtener la fotografia
  _tomarfotografia() async {
    _procesarimagen(ImageSource.camera);
  }

  _procesarimagen(ImageSource origen_foto) async {
    user.fotodePerfilUri = "";
    final _picker = ImagePicker();

    final pickedFile = await _picker.getImage(
      source: origen_foto,
    );
    _image_photo = File(pickedFile!.path);

    //borra el url de la foto despues de mostrarla para que pueda mostrar una nueva  si se selecciona
    /*  if (_image_photo != null) {
      user.fotodePerfilUri = "";
    }*/
    //redibuja el wiget
    setState(() {
      if (pickedFile != null) {
        _image_photo = File(pickedFile.path);
        print("imagen obtenida !!!!!!!!!!!!!!!!!!!" + pickedFile.path);
        buscando_nueva_foto = true;

        //  print("imagen obtenida !!!!!!!!!!!!!!!!!!!" + pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  /* Future _procesarimagen(ImageSource origen_foto) async {
    //final imageFile = File(await ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile) => pickedFile!.path));
    final _picker = ImagePicker();
    print("Procesando IMAGEN --------------------");
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile!.path != null) {
        _image_photo = File(pickedFile.path); //solia funiconar aun nada
        xfile_foto = pickedFile;

        print("this IMAGE SELECTED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        // print("v2: " + jsonEncode(_image_photo));
        print('- Path: ${pickedFile.path}');
        print('- Name: ${pickedFile.name}');
        //   print('- MIME type: ${pickedFile.mimeType}');
        // print("imagen procesada " + File(pickedFile.path).toString());

        if (_image_photo != null) {
          user.fotodePerfilUri = "";
        }
      } else {
        print('No image selected.');
      }
    });
  }*/

//no funciono pero es mejor guardarlo por ahora
  Future _procesarimagen2(ImageSource origen_foto) async {
    final _picker = ImagePicker();
    print("Procesando IMAGEN --------------------");
    //final pickedFile = await _picker.getImage(source: origen_foto,// imageQuality: 100, //nuevo);
    //image_photo = File(pickedFile!.path); //viejo

    //NEW VERSION 05/08/21
    //cambio ahora debe usrse cross_file  - para obtener el XFILE
    //	XFile image = await _picker.pickImage(...)
    // final pickedFile = await _picker.pickImage(source: origen_foto); //viejo2

    // final pickedFile = await _picker.pickImage(source: origen_foto);
    //borra el url de la foto despues de mostrarla para que pueda mostrar una nueva  si se selecciona
    // final fileContent = await pickedFile!.readAsString(); //no lo use

    setState(() {
      /* if (pickedFile!.path != null) {
        _image_photo = File(pickedFile.path); //solia funiconar aun nada
        xfile_foto = pickedFile;

        print("this IMAGE SELECTED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        // print("v2: " + jsonEncode(_image_photo));
        print('- Path: ${pickedFile.path}');
        print('- Name: ${pickedFile.name}');
        //   print('- MIME type: ${pickedFile.mimeType}');
        // print("imagen procesada " + File(pickedFile.path).toString());

        if (_image_photo != null) {
          user.fotodePerfilUri = "";
        }
      } else {
        print('No image selected.');
      }
     if (pickedFile!.path != null) {
        //final fileContent = pickedFile.readAsString();
        // final  json = JsonCodec(pickedFile);
        // _image_photo = pickedFile.path as File;
        // xfile_foto = pickedFile;
        //  _image_photo = fileContent as File;
        // image_photo = pickedFile.path as File; //no funciona
        _image_photo = File(pickedFile.path); //no funciona
        // xfile_foto = pickedFile; //no funciona no puedo obtenerla imagen

     */
    });
  }

  void update_selected_image(String path) {
    this._image_photo = File.fromUri(Uri(path: path));
    this._foto = path;
    //  notifiUid_preferences;
  }

  //..-------------------- maps
  _mostrarmaps(BuildContext context) {
//probemos priemro llendo a esa pagina
    return Container(
        width: double.infinity,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            disabledColor: Colors.amber,
            child: Text(" mi ubicaion"),
            splashColor: Colors.amber,
            color: Colors.orange[200],
            onPressed: () {
              _mostrar_fulldialog_mapas(context);
              //return  MapActivity();
              // Navigator.pushNamed(context, "map1");
            }));
  }

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

  ///---------maps over arriba
  Widget _btn_guardadrinfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        disabledColor: Colors.amber,
        child: Text("Guardar informacion "),
        splashColor: Colors.amber,
        color: Colors.green,
        //icon: Icon(Icons.save),
        onPressed: () async {
          new Container(
            child: CircularProgressIndicator(
              //color: Colors.accents,
              valueColor: AlwaysStoppedAnimation(Colors.green),
            ),
          );

          //actualizar informacion usuario

          setState(() {
            btn_pulsado_bool = true;
          });

          if (user.usuarioNombre == "" ||
              user.teleonoUsuario == "" ||
              user.direccion == "") {
            utilsss.mostraralerta(context, "completar todos los campos");
          }
          if (_pref_user.latitud == 0 || _pref_user.latitud == null) {
            utilsss.mostraralerta(
                context, "porfavor obten la ubicacion actual");
          }

          if (_keyuid_preference != null && _keyuid_preference != "") {
            final provider_perfilUsuario = Provider_PerfilUsuario();
            user.keyUsuario = _keyuid_preference;
            user.notifiUid = _notifiUid_preferences;

            print(_keyuid_preference);
            print(_notifiUid_preferences);
            _pref_user.nombre = user.usuarioNombre;
            // _pref_user.foto = user.fotodePerfilUri;
            _pref_user.telefono = user.teleonoUsuario;
            _pref_user.direccion = user.direccion;

            //cuando tengo la ubicaicon esta en preferencias
            if (_pref_user.latitud != null && _pref_user.latitud != 0.0) {
              user.latitud = _pref_user.latitud;
              user.longitud = _pref_user.longitud;
              print(user.latitud);
              print(user.longitud);

              final productosprovider_http = ProductosProvider(); //iamgen
              // productosprovider_http.crearproducto(productomodel); //y listo

              if (buscando_nueva_foto == true) {
                //_image_photo != null &&
                print("foto nueva");
                //selecciona imagen
                //productomodel.fotoUrl = await productosBlock.subirfoto(image_photo);
                user.fotodePerfilUri =
                    (await productosprovider_http.subirimagen(_image_photo))!;
                //=     url_fire;
                _pref_user.foto = user.fotodePerfilUri;
                provider_perfilUsuario.guardardatosusandofirestore(
                    user, context);
              } else if (_pref_user.foto != null &&
                  buscando_nueva_foto == false) {
                print("foto vieja");

                //cuando hay foto ya guardada
                //ya tenia imagen guardada
                _pref_user.foto = user.fotodePerfilUri;

                provider_perfilUsuario.guardardatosusandofirestore(
                    user, context);
              } else if (user.fotodePerfilUri == "") {
                print("foto vacia");

                user.fotodePerfilUri =
                    "https://i.pinimg.com/474x/c5/64/e5/c564e5b9718ca7f3f49928d3d3cb41e0.jpg";
                //=     url_fire;
                provider_perfilUsuario.guardardatosusandofirestore(
                    user, context);
              }
              //
            } else {
              utilsss.mostraralerta(context, "indica la ubicacion");
            }
          } else {
            print("error datos usuario $user");
          }

          /*

          final usuarioprovider = Ususario_Provider();

          keyuid = await usuarioprovider.getuid2(); //uid firebase

          user.keyUsuario = keyuid;
          print("User UID $keyuid");
          if (keyuid != null) {
            final provider_perfilUsuario = Provider_PerfilUsuario();
            //  if (image_photo != null) {
            //productomodel.fotoUrl = await productosBlock.subirfoto(image_photo);
            //productosprovider_http.subirimagen(image_photo);
            //}
            provider_perfilUsuario
                .editar_usuario(user)
                .then((value) => print(user.toJson()));
          } */
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('image_photo', _image_photo));
  }

  Widget _priebafirestore1() {
    //ene l vide el trae una sita de datos de esta amnera
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("tareas").snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          //si esta vacia

          return CircularProgressIndicator();
        } else {
          //obtenemos el snapshop y creamos la vision
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  docs[index].data as Map<String, dynamic>;
              //ahora retrona la vista
              return ListTile(
                leading: Checkbox(
                  value: data['nombre'],
                  onChanged: (bool? value) {},
                ),
                title: Text(data['apellido']),
              );
            },
          );
        }
      },
    );
  }

//3.guardar -casi pero no me deja poner los datos ...
  Future<void> _traerdatosfirebase(String uid, BuildContext context) async {
    final DocumentReference users_ref = FirebaseFirestore.instance
        .collection('Users')
        .doc('clients')
        .collection("info")
        .doc(uid);

    users_ref.get().then((value) {
      //print(value.data()); //imprime

      var user2 = Usuario.fromdocument(value);
      print(user.teleonoUsuario); //imprime

      _nombre = user2.usuarioNombre;
      user.usuarioNombre = _nombre;
      _foto = user2.fotodePerfilUri;
      user.fotodePerfilUri = user2.fotodePerfilUri;
      print("firebase");
      print(_nombre);
      print(_foto);
    });
  }

//3.1 guardar_v2
  _trarinfouser(String uid) {
    var users_ref = FirebaseFirestore.instance
        .collection('Users')
        .doc('clients')
        .collection("info")
        .doc(uid)
        .snapshots();
    /*StreamBuilder(
        stream: users_ref,
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
        });*/
  }
}
