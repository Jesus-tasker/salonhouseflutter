import 'package:flutter/material.dart';

class Ui_provider extends ChangeNotifier {
  //opcion del menu seleccionada
  int _selectedMneuopt = 0;

  //getter
  int get selectedMneuopt {
    return this._selectedMneuopt;
  }

//setter
  set selectedMneuopt(int i) {
    this._selectedMneuopt = i;
    notifyListeners(); //es como un notifi adapter
  }
}
