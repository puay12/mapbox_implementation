import 'package:mapbox_implementation/datasource/search_remote_data_source.dart';
import 'package:mapbox_implementation/entities/search_response_entity.dart';
import 'package:mapbox_implementation/model/search_response_model.dart';

abstract class SearchRepository {
  Future<SearchResponseEntity?> getSearchRecommendations(String searchText);
}

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _searchRemoteDataSource;

  SearchRepositoryImpl(this._searchRemoteDataSource);

  @override
  Future<SearchResponseEntity?> getSearchRecommendations(String searchText) async {
    SearchResponseModel? result = await _searchRemoteDataSource.getSearchRecommendations(searchText);

    return result;
  }
}