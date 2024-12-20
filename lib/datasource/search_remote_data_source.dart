import 'package:dio/dio.dart';
import 'package:mapbox_implementation/common/constants.dart';

import '../model/search_response_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchResponseModel?> getSearchRecommendations(String searchText);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final dio = Dio();

  @override
  Future<SearchResponseModel?> getSearchRecommendations(String searchText) async {
    SearchResponseModel? result;

    try{
      final response = await dio.get(
          BASE_URL + SEARCH_FORWARD_GEOCODE_URL,
          queryParameters: {
            "q": searchText,
            "access_token": ACCESS_TOKEN,
            "country": "id"
          }
      );
      result = SearchResponseModel.fromJson(response.data);
    } catch(e) {
      print("Error sending search request : ${e.toString()}");
    }

    return result;
  }
}