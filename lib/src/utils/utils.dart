//aqui podemos definir si un dato es un numero o tal
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonhouse/src/pagues/navegador/perfil_usuario_navi.dart';
import 'package:salonhouse/src/utils/utils_textos.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s); //si se puede parcear a  nuemro
  return (n == null) ? false : true; //si n=null else = true
}

//mensaje de aler dialog
mostraralerta(BuildContext context, String mensaje) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(' informacion incorrecta'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('ok'))
          ],
        );
      });
}

show_buttonsheep_util(BuildContext contex, String dato) {
  return new Container(
//        height: 320.0,
//      color: Colors.greenAccent,
    child: new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, mainAxisSpacing: 5.0, childAspectRatio: 1.0),
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
              // child: new Image.asset('images/${urlItems[index]}', width: 50.0, height: 50.0, fit: BoxFit.fill,),
            ),
            new Text(dato)
          ],
        );
      },
      //itemCount: nameItems.length,
    ),
  );
}

show_buttonsheep_asignado(BuildContext contex, String dato) {
  return new Container(
//        height: 320.0,
//      color: Colors.greenAccent,
    child: new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, mainAxisSpacing: 5.0, childAspectRatio: 1.0),
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
              // child: new Image.asset('images/${urlItems[index]}', width: 50.0, height: 50.0, fit: BoxFit.fill,),
            ),
            new Text(dato)
          ],
        );
      },
      //itemCount: nameItems.length,
    ),
  );
}

mostrardialogbuttonshet(BuildContext contex, String dato) {
  showModalBottomSheet(
    context: contex,
    builder: (context) => GestureDetector(
      child: Container(
        height: 50,
        child: Row(children: [
          Text('Agregado :$dato'),
          Icon(Icons.delete),
        ]),
      ),
      onVerticalDragStart: (_) {},
    ),
  );
}

mostrardialogbuttonshetv2_selec(
  BuildContext contex,
  String dato,
) {
  showModalBottomSheet(
    backgroundColor: Colors.green,
    context: contex,
    builder: (context) => GestureDetector(
      child: Container(
        height: 50,
        child: Row(children: [
          Text('Agregado :$dato'),
          Icon(Icons.check),
        ]),
      ),
      onVerticalDragStart: (_) {},
    ),
  );
}

mostrar_fulldialog(BuildContext context, int i) {
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
                  child: FlutterLogo()), //aqui mostraba el logo de flutter
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

cuadrado_qr() {
  return Card(
      color: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: IconButton(icon: Icon(Icons.qr_code), onPressed: null)));
}

mostrardialogbuttonshetv3_pedidoagendado(
  BuildContext contex,
  String dato,
) {
  showModalBottomSheet(
    backgroundColor: Colors.green,
    context: contex,
    builder: (context) => GestureDetector(
      child: Container(
        height: 100,
        child: Column(
          children: [
            Row(children: [
              Icon(Icons.check),
              Text(dato,
                  textScaleFactor: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      leadingDistribution: TextLeadingDistribution.even,
                      color: Colors.white,
                      decoration: TextDecoration.none)),
            ]),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Perfil_Usuario_navi()),
                    (r) => false,
                  );
                },
                child: util_texts_white_2_agregattamano("ver estado", 1))
          ],
        ),
      ),
      onVerticalDragStart: (_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Perfil_Usuario_navi()),
          (r) => false,
        );
      },
      onTap: () {},
    ),
  );
}
