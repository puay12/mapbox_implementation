import 'package:get_it/get_it.dart';
import 'package:mapbox_implementation/datasource/search_remote_data_source.dart';
import 'package:mapbox_implementation/provider/search_recommendations_provider.dart';
import 'package:mapbox_implementation/repository/search_repository.dart';
import 'package:mapbox_implementation/usecase/get_search_recommendations.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Data Sources
  sl.registerSingleton<SearchRemoteDataSource>(SearchRemoteDataSourceImpl());

  // Repositories
  sl.registerSingleton<SearchRepository>(SearchRepositoryImpl(sl()));

  // Use Cases
  sl.registerSingleton<GetSearchRecommendationsUseCase>(GetSearchRecommendationsUseCase(sl()));

  // Provider
  sl.registerSingleton<SearchRecommendationsProvider>(SearchRecommendationsProvider(sl()));
}