import 'package:flutter/material.dart';

Widget utils_clip_imagenlocal() {
  return ClipRRect(
    child: Expanded(child: Image(image: AssetImage("assets/dado1_cara.png"))),
  );
}

Widget util_texts(String mensaje) {
  return Container(
      //alignment: Alignment.bottomCenter,
      child: Text(mensaje,
          textScaleFactor: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(

              //leadingDistribution: TextLeadingDistribution.even,
              color: Colors.white,
              decoration: TextDecoration.none)));
}

Widget util_texts_black1_definido(String mensaje) {
  return Container(
      //  alignment: Alignment.bottomCenter,
      child: Text("nombre",
          textScaleFactor: 0.5,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              // leadingDistribution: TextLeadingDistribution.even,
              color: Colors.black,
              decoration: TextDecoration.none)));
}

Widget util_texts_black2_agregattamano(String mensaje, double scale) {
  return Container(
      //  alignment: Alignment.bottomCenter,
      child: Text(mensaje,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: scale,
          style:
              TextStyle(color: Colors.black, decoration: TextDecoration.none)));
}

Widget util_texts_colors_agregattamano(String mensaje, double scale) {
  return Container(
      //  alignment: Alignment.bottomCenter,
      child: Text(mensaje,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: scale,
          style:
              TextStyle(color: Colors.black, decoration: TextDecoration.none)));
}

Widget util_texts_white_2_agregattamano(String mensaje, double scale) {
  return Container(
      //  alignment: Alignment.bottomCenter,
      child: Text(mensaje,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: scale,
          style:
              TextStyle(color: Colors.white, decoration: TextDecoration.none)));
}

Widget util_texts_white_3_texto_extenso(String mensaje, double scale) {
  return Container(
      //  alignment: Alignment.bottomCenter,
      child: Text(mensaje,
          // overflow: TextOverflow.ellipsis,
          textScaleFactor: scale,
          style:
              TextStyle(color: Colors.white, decoration: TextDecoration.none)));
}

util_imague_circle(String ruta, double radio) {
  return Container(
    child: CircleAvatar(
      radius: radio,
      backgroundImage: AssetImage(ruta),
    ),
  );
}

Widget util_limit(String mensaje) {
  return Container(
      //alignment: Alignment.bottomCenter,
      child: Text(mensaje,
          textScaleFactor: 0.5,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
          )));
}
