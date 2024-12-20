import 'package:mapbox_implementation/datasource/search_remote_data_source.dart';
import 'package:mapbox_implementation/entities/search_response_entity.dart';

abstract class SearchRepository {
  Future<SearchResponseEntity?> getSearchRecommendations(String searchText);
}

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _searchRemoteDataSource;

  SearchRepositoryImpl(this._searchRemoteDataSource);

  @override
  Future<SearchResponseEntity?> getSearchRecommendations(String searchText) async {
    var encodedText = Uri.parse(searchText);

    return await _searchRemoteDataSource.getSearchRecommendations(encodedText.toString());
  }
}