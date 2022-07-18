import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FestivalScreen extends StatefulWidget {
  const FestivalScreen({Key? key}) : super(key: key);

  @override
  State<FestivalScreen> createState() => _FestivalScreenState();
}

class _FestivalScreenState extends State<FestivalScreen> {
  static final LatLng _kMapCenter =
      LatLng(37.6324657, 127.0776803);
  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("festival screen"),
        ),
        body: GoogleMap(
          initialCameraPosition: _kInitialPosition,
        ));
  }
}
