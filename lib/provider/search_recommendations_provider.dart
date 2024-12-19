import 'package:flutter/cupertino.dart';
import 'package:mapbox_implementation/entities/search_response_entity.dart';
import 'package:mapbox_implementation/usecase/get_search_recommendations.dart';

class SearchRecommendationsProvider extends ChangeNotifier {
  final GetSearchRecommendations _getSearchRecommendations;

  SearchRecommendationsProvider(this._getSearchRecommendations);

  bool isLoading = false;
  bool isError = false;

  SearchResponseEntity? _searchResults;
  SearchResponseEntity? get searchResults => _searchResults;

  Future<void> getSearchResults(String searchText) async {
    try {
      isLoading = true;
      notifyListeners();
      _searchResults = await _getSearchRecommendations(params: searchText);
      isLoading = false;
      notifyListeners();
    } catch(e) {
      print("Error getting search recommendations: ${e.toString()}");
      isError = true;
      notifyListeners();
    }
  }

  Future<void> clearResults() async {
    try {
      _searchResults = null;
      notifyListeners();
    } catch(e) {
      print("Error clearing search results: ${e.toString()}");
      isError = true;
      notifyListeners();
    }
  }
}