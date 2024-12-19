import 'package:equatable/equatable.dart';

class SearchResponseEntity extends Equatable {
  final String? type;
  final List<FeatureEntity>? features;
  final String? attribution;

  const SearchResponseEntity({
    this.type,
    this.features,
    this.attribution,
  });

  @override
  List<Object?> get props {
    return [
      type, features, attribution
    ];
  }
}

class FeatureEntity extends Equatable {
  final String? type;
  final String? id;
  final GeometryEntity? geometry;
  final PropertiesEntity? properties;

  const FeatureEntity({
    this.type,
    this.id,
    this.geometry,
    this.properties,
  });

  @override
  List<Object?> get props {
    return [
      type, id, geometry, properties
    ];
  }

}

class GeometryEntity extends Equatable {
  final String? type;
  final List<double>? coordinates;

  GeometryEntity({
    this.type,
    this.coordinates,
  });

  @override
  List<Object?> get props {
    return [
      type, coordinates
    ];
  }
}

class PropertiesEntity extends Equatable {
  final String? mapboxId;
  final String? featureType;
  final String? fullAddress;
  final String? name;
  final String? namePreferred;
  final CoordinatesEntity? coordinates;
  final String? placeFormatted;
  final List<double>? bbox;
  final ContextEntity? context;

  PropertiesEntity({
    this.mapboxId,
    this.featureType,
    this.fullAddress,
    this.name,
    this.namePreferred,
    this.coordinates,
    this.placeFormatted,
    this.bbox,
    this.context,
  });

  @override
  List<Object?> get props {
    return [
      mapboxId,
      featureType,
      fullAddress,
      name,
      namePreferred,
      coordinates,
      placeFormatted,
      bbox,
      context,
    ];
  }
}

class ContextEntity extends Equatable {
  final RegiontEntity? region;
  final CountryEntity? country;
  final LocalityEntity? place;
  final LocalityEntity? locality;

  ContextEntity({
    this.region,
    this.country,
    this.place,
    this.locality,
  });

  @override
  List<Object?> get props {
    return [
      region,
      country,
      place,
      locality,
    ];
  }
}

class CountryEntity extends Equatable {
  final String? mapboxId;
  final String? name;
  final String? wikidataId;
  final String? countryCode;
  final String? countryCodeAlpha3;

  CountryEntity({
    this.mapboxId,
    this.name,
    this.wikidataId,
    this.countryCode,
    this.countryCodeAlpha3,
  });

  @override
  List<Object?> get props {
    return [
      mapboxId,
      name,
      wikidataId,
      countryCode,
      countryCodeAlpha3,
    ];
  }

}

class LocalityEntity extends Equatable {
  final String? mapboxId;
  final String? name;
  final String? wikidataId;

  LocalityEntity({
    this.mapboxId,
    this.name,
    this.wikidataId,
  });

  @override
  List<Object?> get props {
    return [
      mapboxId,
      name,
      wikidataId,
    ];
  }
}

class RegiontEntity extends Equatable {
  final String? mapboxId;
  final String? name;
  final String? wikidataId;
  final String? regionCode;
  final String? regionCodeFull;

  RegiontEntity({
    this.mapboxId,
    this.name,
    this.wikidataId,
    this.regionCode,
    this.regionCodeFull,
  });

  @override
  List<Object?> get props {
    return [
      mapboxId,
      name,
      wikidataId,
      this.regionCode,
      this.regionCodeFull,
    ];
  }
}

class CoordinatesEntity extends Equatable {
  final double? longitude;
  final double? latitude;

  CoordinatesEntity({
    this.longitude,
    this.latitude,
  });

  @override
  List<Object?> get props {
    return [
      longitude, latitude
    ];
  }
}