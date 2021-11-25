import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salonhouse/src/preferencias_usuario/preferences_user.dart';

//ESTA FUNCIONA PARA MOSTRAR MI UBICAICON ACTUAL Y AGREGAR UNA AMRCA FUE
//LA RIMERA EN FUNCIONAR PARA MOSTRAR SOLO MAPA Y UBICACION
class MapActivity extends StatefulWidget {
  @override
  _MapActivityState createState() => _MapActivityState();
}

class _MapActivityState extends State<MapActivity> {
  late LatLng _center;
  late Position currentLocation;
  final _pref_user = new PreferenciasUsuario();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    if (currentLocation.latitude != 0.0) {
      _pref_user.latitud = currentLocation.latitude;
      _pref_user.longitud = currentLocation.longitude;
      print("location actualizada " + _pref_user.latitud.toString());
    }

    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print('center $_center');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    while (currentLocation == null) {
      getUserLocation();
    }

    var markers;
    if (currentLocation != null) {
      return GoogleMap(
          initialCameraPosition:
              //CameraPosition(target: LatLng(-33.4631318, -70.6435017), zoom: 12), markers: Set<Marker>.of(markers.values),);
              CameraPosition(target: _center, zoom: 16),
          markers: <Marker>{
            Marker(
                position: _center,
                markerId: MarkerId('marca1'),
                onTap: _alertdialog_siguientepagina),
          });
      // throw UnimplementedError();
    } else {
      return AlertDialog(
          title: Text('activa tu gps  pulsa para buscar de nuevo '));
    }
  }

  _alertdialog_siguientepagina() {
    print('ppulsado ');
    AlertDialog(
      title: new Text("Alert!!"),
      content: new Text("You are awesome!"),
      actions: <Widget>[
        new FlatButton(
          child: new Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
