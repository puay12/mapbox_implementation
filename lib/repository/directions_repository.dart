import 'package:mapbox_implementation/datasource/search_remote_data_source.dart';

import '../datasource/directions_remote_data_source.dart';
import '../entities/directions_response_entity.dart';

abstract class DirectionsRepository {
  Future<DirectionsResponseEntity?> retrieveDirections(String profile, List<Map<String,String>> coordinates);
}

class SearchRepositoryImpl implements DirectionsRepository {
  final DirectionsRemoteDataSource _directionsRemoteDataSource;

  SearchRepositoryImpl(this._directionsRemoteDataSource);

  @override
  Future<DirectionsResponseEntity?> retrieveDirections(String profile, List<Map<String,String>> coordinates) async {
    List<String> formattedCoordinates = [];
    for (var pair in coordinates) {
      formattedCoordinates.add("${pair.keys};${pair.values}");
    }

    return await _directionsRemoteDataSource.retrieveDirections(profile, formattedCoordinates);
  }
}