import 'package:mapbox_implementation/entities/directions_response_entity.dart';
import 'package:mapbox_implementation/repository/directions_repository.dart';

import 'generic/usecase_generic.dart';

class RetrieveDirectionsUseCase implements UseCase<DirectionsResponseEntity?, Map<String, dynamic>> {
  DirectionsRepository _directionsRepository;

  RetrieveDirectionsUseCase(this._directionsRepository);

  @override
  Future<DirectionsResponseEntity?> call({Map<String, dynamic>? params}) async {
    return await _directionsRepository.retrieveDirections(params!['profile'], params['coordinates']);
  }

}