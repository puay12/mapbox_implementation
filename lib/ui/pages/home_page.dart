import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MapWidget(
          styleUri: MapboxStyles.MAPBOX_STREETS,
          key: ValueKey("mapWidget"),
          onMapCreated: _onMapCreated,
          onCameraChangeListener: _onCameraChangeListener,
        )
    );
  }

  _onMapCreated(MapboxMap mapboxmap) {
    mapboxmap.setCamera(CameraOptions(
        center: Point(coordinates: Position(-1.2385228248171842, 116.84736863711628)),
        padding: MbxEdgeInsets( top: 40.0, left: 5.0, bottom: 80.0, right: 5.0),
        zoom: 15.5,
        bearing: -17.6,
        pitch: 60
    ));
  }

  _onCameraChangeListener(CameraChangedEventData data) {
    print("CameraChangedEventData");
    print("Position (longitude): ${data.cameraState.center.coordinates.lng}");
    print("Position (latitude): ${data.cameraState.center.coordinates.lat}");
  }
}
