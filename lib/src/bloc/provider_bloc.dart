import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:salonhouse/src/bloc/login_bloc.dart';
import 'package:salonhouse/src/bloc/productos_block.dart';
export 'package:salonhouse/src/bloc/login_bloc.dart';

class Provider_bloc extends InheritedWidget {
  ///provider es un wiget que con claves puede almacenar informacion y ubicarla usando patron block

  final loginBloc = new LoginBloc(); //login block
  final _productoblock = new ProductosBlock(); //productos block

  static Provider_bloc? _instancia;

  factory Provider_bloc({Key? key, required Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider_bloc._internal(key: key, child: child);
    }
    // return new Provider(key: key, child: child);
    //return Provider(key: key, child: child);
    return _instancia!;
  }

  Provider_bloc._internal({Key? key, required Widget child})
      : super(key: key, child: child);

  @override //cone sto buscamos la ingormacion
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    //busca algo que se llame provider y tratao como provider eso es lo que dice
    return (context.dependOnInheritedWidgetOfExactType<Provider_bloc>()
            as Provider_bloc)
        .loginBloc;
  }

//pocudto
//home y donde agregamos el producto
  static ProductosBlock product_block(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider_bloc>()
            as Provider_bloc)
        ._productoblock;
  }
}
/*
    //return Provider(key: key, child: child);
  //   return _instancia; //= new Provider._internal(key: key, child: child);
   // return Provider(key: key, child: child); */