import 'package:dio/dio.dart';
import 'package:mapbox_implementation/common/constants.dart';
import 'package:mapbox_implementation/model/directions_response_model.dart';

abstract class DirectionsRemoteDataSource {
  Future<DirectionsResponseModel?> retrieveDirections(String profile, List<String> coordinates);
}

class DirectionsRemoteDataSourceImpl implements DirectionsRemoteDataSource {
  final dio = Dio();

  @override
  Future<DirectionsResponseModel?> retrieveDirections(String profile, List<String> coordinates) async {
    DirectionsResponseModel? result;

    try{
      final response = await dio.get(
          "$BASE_URL$DIRECTIONS_URL/$profile/${coordinates[0]};${coordinates[1]}",
          queryParameters: {
            "access_token": ACCESS_TOKEN
          }
      );
      result = DirectionsResponseModel.fromJson(response.data);
    } catch(e) {
      print("Error sending directions request : ${e.toString()}");
    }

    return result;
  }
}