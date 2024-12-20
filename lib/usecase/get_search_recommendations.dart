import 'package:mapbox_implementation/entities/search_response_entity.dart';
import 'package:mapbox_implementation/repository/search_repository.dart';
import 'package:mapbox_implementation/usecase/generic/usecase_generic.dart';

class GetSearchRecommendationsUseCase implements UseCase<SearchResponseEntity?, String> {
  SearchRepository _searchRepository;

  GetSearchRecommendationsUseCase(this._searchRepository);

  @override
  Future<SearchResponseEntity?> call({String? params}) async {
    return await _searchRepository.getSearchRecommendations(params!);
  }
  
}