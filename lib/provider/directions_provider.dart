import 'package:flutter/cupertino.dart';
import 'package:mapbox_implementation/entities/directions_response_entity.dart';
import 'package:mapbox_implementation/usecase/retrieve_directions.dart';

class DirectionsProvider extends ChangeNotifier {
  final RetrieveDirectionsUseCase _retrieveDirectionsUseCase;

  DirectionsProvider(this._retrieveDirectionsUseCase);

  bool isLoading = false;
  bool isError = false;

  DirectionsResponseEntity? _directionResult;
  DirectionsResponseEntity? get directionResult => _directionResult;

  Future<void> retrieveDirections(String profile, List<Map<String, String>> coordinates) async {
    try {
      isLoading = true;
      notifyListeners();
      _directionResult = await _retrieveDirectionsUseCase(
          params: {
            "profile": profile,
            "coordinates": coordinates
          }
      );
      isLoading = false;
      notifyListeners();
    } catch(e) {
      print("Error retrieving directions: ${e.toString()}");
      isError = true;
      notifyListeners();
    }
  }

  Future<void> clearDirections() async {
    try {
      _directionResult = null;
      notifyListeners();
    } catch(e) {
      print("Error clearing direction results: ${e.toString()}");
      isError = true;
      notifyListeners();
    }
  }
}