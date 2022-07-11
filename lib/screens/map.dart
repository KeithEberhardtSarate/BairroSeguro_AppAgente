import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../providers/usuarios.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _initialCameraPosition =
      CameraPosition(target: LatLng(37.773972, -122.431297), zoom: 11.5);

  late GoogleMapController _googleMapController;
  late Marker? _origin;
  late Marker? _destionation;
  late DatabaseReference _solicitacoesRef;
  late StreamSubscription<DatabaseEvent> _solicitacoesChangedSubscription;

  static var location = new Location();
  var minhaLocalizacao;

  @override
  void initState() {
    _solicitacoesRef = FirebaseDatabase.instance.ref('solicitacoes');

    _getLocation();
    super.initState();

    _solicitacoesChangedSubscription =
        _solicitacoesRef.onChildChanged.listen((DatabaseEvent event) {
      if (event.snapshot.value != null &&
          (event.snapshot.value as Map)['status'] == 'aceita') {
        double lat = double.parse((event.snapshot.value as Map)['lat']);
        double lon = double.parse((event.snapshot.value as Map)['lon']);
        _addMarkerDestination(LatLng(lat, lon));
        CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lat, lon)));
      }
    });
  }

  void _getLocation() async {
    Location location = Location();

    final LocationData pos = await location.getLocation();
    _addMarkerOrigin(LatLng(pos.latitude!, pos.longitude!));
    _addMarkerDestination(LatLng(pos.latitude!, pos.longitude!));
    setState(() {
      minhaLocalizacao = pos;
    });

    CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(minhaLocalizacao.latitude, minhaLocalizacao.longitude)));
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {
            if (_origin != null) _origin!,
            if (_destionation != null) _destionation!,
          }),
    );
  }

  void _addMarkerOrigin(LatLng pos) {
    setState(() {
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origem'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
    });
  }

  void _addMarkerDestination(LatLng pos) {
    setState(() {
      _destionation = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destino'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );
    });
  }
}
