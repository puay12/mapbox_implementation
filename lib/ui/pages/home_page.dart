import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapboxMap? mapbox;
  PointAnnotationManager? pointAnnotationManager;
  PointAnnotationOptions? pointAnnotationOptions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MapWidget(
          key: ValueKey("mapWidget"),
          onMapCreated: _onMapCreated,
          onCameraChangeListener: _onCameraChangeListener,
        )
    );
  }

  _onMapCreated(MapboxMap mapboxmap) async {
    mapbox = mapboxmap;

    mapbox?.setCamera(CameraOptions(
        center: Point(coordinates: Position(116.84736863711628, -1.2385228248171842)),
        padding: MbxEdgeInsets( top: 40.0, left: 5.0, bottom: 80.0, right: 5.0),
        zoom: 16.0,
        bearing: -10,
        pitch: 60
    )
    );
    mapbox?.loadStyleURI(MapboxStyles.MAPBOX_STREETS);

    pointAnnotationManager = await mapbox?.annotations.createPointAnnotationManager();

    // Load the image from assets
    final ByteData bytes = await rootBundle.load('assets/custom-icon.png');
    final Uint8List imageData = bytes.buffer.asUint8List();

    // Create a PointAnnotationOptions
    pointAnnotationOptions = PointAnnotationOptions(
        geometry: Point(coordinates: Position(116.84736863711628, -1.2385228248171842)), // Example coordinates
        image: imageData,
        iconSize: 1.5
    );

    // Add the annotation to the map
    pointAnnotationManager?.create(pointAnnotationOptions!);
  }

  _onCameraChangeListener(CameraChangedEventData data) {
    print("CameraChangedEventData");
    print("Position (longitude): ${data.cameraState.center.coordinates.lng}");
    print("Position (latitude): ${data.cameraState.center.coordinates.lat}");
  }
}
