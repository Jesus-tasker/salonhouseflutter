import 'package:flutter/material.dart';

class Carrito_datos extends InheritedWidget {
  Carrito_datos(key, {required this.seleccion, required this.child})
      : super(key: key, child: child);

  final Widget child;
  final String seleccion;

  static Carrito_datos? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Carrito_datos>();
  }

//notifica a los hijos cuando el valor cambia
  @override
  bool updateShouldNotify(Carrito_datos oldWidget) {
    // return true;
    return seleccion !=
        oldWidget.seleccion; //el widget se redibuja si esto cambia
  }
}
