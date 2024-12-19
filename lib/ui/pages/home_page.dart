import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_implementation/entities/search_response_entity.dart';
import 'package:mapbox_implementation/provider/search_recommendations_provider.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    pointAnnotationManager?.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            _maps(context),
            _searchArea(context)
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

  Widget _searchArea(BuildContext context) {
    return Column(
      children: [
        _search(context),
        Consumer<SearchRecommendationsProvider>(
            builder: (context, state, _) {
              return (state.searchResults != null)
                  ? _searchResultBox(context)
                  : const SizedBox.shrink();
            }
        )
      ],
    );
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
        margin: const EdgeInsets.only(top: 32, left: 10, right: 10, bottom: 12),
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
      child: Consumer<SearchRecommendationsProvider>(
        builder: (context, provider, _) {
          return TextField(
            onSubmitted: (value) async {
              if (value.isNotEmpty) {
                await provider.getSearchResults(value);
              }
            },
            // onChanged: (value) async {
            //   if (value.isNotEmpty) {
            //     // _startSearching(value);
            //     await provider.getSearchResults(value);
            //   }
            // },
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
          );
        }
      ),
    );
  }

  // Future<void> _startSearching(String value) async {
  //   print("Error getting recommendations");
  //   await context.watch<SearchRecommendationsProvider>().getSearchResults(value);
  // }

  Widget _suffixIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        searchText = null;
        controller.clear();
        focusNode.unfocus();
      },
      child: const Icon(
        Icons.clear,
        size: 20,
        color: Colors.grey
      ),
    );
  }

  Widget _searchResultBox(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Colors.grey
          )
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8,),
      child: Consumer<SearchRecommendationsProvider>(
        builder: (context, state, _) {
          return (state.isLoading)
              ? const Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: const Center(
                      child: CircularProgressIndicator(color: Colors.grey),
                    ),
                )
              : (state.searchResults != null)
                  ? Container(
                      height: height * 0.45,
                      margin: const EdgeInsets.only(top: 8),
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return _searchResultItem(
                            context,
                            state.searchResults!.features![index].properties!
                          );
                        }
                      )
                    )
                  : const SizedBox.shrink();
            }
          )
    );
  }

  Widget _searchResultItem(BuildContext context, PropertiesEntity item) {
    num long = item.coordinates?.longitude as num;
    num lat = item.coordinates?.latitude as num;

    return GestureDetector(
      onTap: () => _onSearchItemTapped(Position(long, lat)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.placeFormatted!,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              item.fullAddress!,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
                color: Colors.grey
              ),
            ),
            const Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onSearchItemTapped(Position position) async {
    _clearPreviousAnnotation();
    cameraPosition = position;
    _setCameraPosition();
    _setAnnotation();
    print("New Annotation Coordinates\nLong : ${cameraPosition?.lng}, Lat: ${cameraPosition?.lat}");
  }
}
