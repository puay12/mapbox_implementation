import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  String? searchText;
  MapboxMap? mapbox;
  Position? cameraPosition;
  PointAnnotationManager? pointAnnotationManager;
  PointAnnotationOptions? pointAnnotationOptions;

  @override
  void initState() {
    super.initState();
    
    cameraPosition = Position(116.84736863711628, -1.2385228248171842);

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        controller.text = searchText ?? "";
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            _maps(context),
            _search(context)
          ],
        ),
      ),
    );
  }
  
  Widget _maps(BuildContext context) {
    return MapWidget(
      key: ValueKey("mapWidget"),
      onMapCreated: _onMapCreated,
      onTapListener: _onTapListener,
    );
  }

  void _onMapCreated(MapboxMap mapboxmap) async {
    mapbox = mapboxmap;
    mapbox?.loadStyleURI(MapboxStyles.MAPBOX_STREETS);

    _setCameraPosition();
    _setAnnotation();
  }
  
  void _onTapListener(MapContentGestureContext mapContentGestureContext) {
    _clearPreviousAnnotation();
    cameraPosition = mapContentGestureContext.point.coordinates;
    _setCameraPosition();
    _setAnnotation();
    print("New Annotation Coordinates\nLong : ${cameraPosition?.lng}, Lat: ${cameraPosition?.lat}");
  }
  
  void _setCameraPosition() {
    mapbox?.setCamera(CameraOptions(
        center: Point(coordinates: cameraPosition!),
        padding: MbxEdgeInsets( top: 40.0, left: 5.0, bottom: 80.0, right: 5.0),
        zoom: 17.0,
        bearing: 0,
        pitch: 60
    ));
  }
  
  void _setAnnotation() async {
    pointAnnotationManager = await mapbox?.annotations.createPointAnnotationManager();

    // Load the image from assets
    final ByteData bytes = await rootBundle.load('assets/custom-icon.png');
    final Uint8List imageData = bytes.buffer.asUint8List();

    pointAnnotationOptions = PointAnnotationOptions(
        geometry: Point(coordinates: cameraPosition!), // Example coordinates
        image: imageData,
        iconSize: 1.5
    );

    pointAnnotationManager?.create(pointAnnotationOptions!);
  }

  void _clearPreviousAnnotation() {
    pointAnnotationManager?.deleteAll();
  }

  Widget _search(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                color: Colors.grey
            )
        ),
        margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8,),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _searchIcon(context),
            Expanded(
              child: _searchInput(context),
            ),
            // _filter(context),
          ],
        ),
      ),
    );
  }

  Widget _searchIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8,),
      child: const Icon(
        Icons.search,
        size: 20,
      ),
    );
  }

  Widget _searchInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: TextField(
        onSubmitted: (value) {},
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 16
        ),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Colors.grey
          ),
          suffixIcon: _suffixIcon(context),
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _suffixIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchText != null && searchText!.isNotEmpty) {
          searchText = null;
          controller.clear();
          focusNode.unfocus();
        }
      },
      child: const Icon(
        Icons.clear,
        size: 20,
      ),
    );
  }

}
