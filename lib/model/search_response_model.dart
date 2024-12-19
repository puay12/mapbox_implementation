import 'dart:convert';

import 'package:mapbox_implementation/entities/search_response_entity.dart';

SearchResponseModel searchResponseModelFromJson(String str) => SearchResponseModel.fromJson(json.decode(str));

String searchResponseModelToJson(SearchResponseModel data) => json.encode(data.toJson());

class SearchResponseModel extends SearchResponseEntity {
  final String? type;
  final List<FeatureModel>? features;
  final String? attribution;

  SearchResponseModel({
    this.type,
    this.features,
    this.attribution,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) => SearchResponseModel(
    type: json["type"],
    features: json["features"] == null ? [] : List<FeatureModel>.from(json["features"]!.map((x) => FeatureModel.fromJson(x))),
    attribution: json["attribution"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "features": features == null ? [] : List<dynamic>.from(features!.map((x) => x.toJson())),
    "attribution": attribution,
  };
}

class FeatureModel extends FeatureEntity {
  final String? type;
  final String? id;
  final GeometryModel? geometry;
  final PropertiesModel? properties;

  FeatureModel({
    this.type,
    this.id,
    this.geometry,
    this.properties,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) => FeatureModel(
    type: json["type"],
    id: json["id"],
    geometry: json["geometry"] == null ? null : GeometryModel.fromJson(json["geometry"]),
    properties: json["properties"] == null ? null : PropertiesModel.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "geometry": geometry?.toJson(),
    "properties": properties?.toJson(),
  };
}

class GeometryModel extends GeometryEntity {
  final String? type;
  final List<double>? coordinates;

  GeometryModel({
    this.type,
    this.coordinates,
  });

  factory GeometryModel.fromJson(Map<String, dynamic> json) => GeometryModel(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class PropertiesModel extends PropertiesEntity {
  final String? mapboxId;
  final String? featureType;
  final String? fullAddress;
  final String? name;
  final String? namePreferred;
  final CoordinatesModel? coordinates;
  final String? placeFormatted;
  final List<double>? bbox;
  final ContextModel? context;

  PropertiesModel({
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

  factory PropertiesModel.fromJson(Map<String, dynamic> json) => PropertiesModel(
    mapboxId: json["mapbox_id"],
    featureType: json["feature_type"],
    fullAddress: json["full_address"],
    name: json["name"],
    namePreferred: json["name_preferred"],
    coordinates: json["coordinates"] == null ? null : CoordinatesModel.fromJson(json["coordinates"]),
    placeFormatted: json["place_formatted"],
    bbox: json["bbox"] == null ? [] : List<double>.from(json["bbox"]!.map((x) => x?.toDouble())),
    context: json["context"] == null ? null : ContextModel.fromJson(json["context"]),
  );

  Map<String, dynamic> toJson() => {
    "mapbox_id": mapboxId,
    "feature_type": featureType,
    "full_address": fullAddress,
    "name": name,
    "name_preferred": namePreferred,
    "coordinates": coordinates?.toJson(),
    "place_formatted": placeFormatted,
    "bbox": bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
    "context": context?.toJson(),
  };
}

class ContextModel extends ContextEntity {
  final RegionModel? region;
  final CountryModel? country;
  final LocalityModel? place;
  final LocalityModel? locality;

  ContextModel({
    this.region,
    this.country,
    this.place,
    this.locality,
  });

  factory ContextModel.fromJson(Map<String, dynamic> json) => ContextModel(
    region: json["region"] == null ? null : RegionModel.fromJson(json["region"]),
    country: json["country"] == null ? null : CountryModel.fromJson(json["country"]),
    place: json["place"] == null ? null : LocalityModel.fromJson(json["place"]),
    locality: json["locality"] == null ? null : LocalityModel.fromJson(json["locality"]),
  );

  Map<String, dynamic> toJson() => {
    "region": region?.toJson(),
    "country": country?.toJson(),
    "place": place?.toJson(),
    "locality": locality?.toJson(),
  };
}

class CountryModel extends CountryEntity {
  final String? mapboxId;
  final String? name;
  final String? wikidataId;
  final String? countryCode;
  final String? countryCodeAlpha3;

  CountryModel({
    this.mapboxId,
    this.name,
    this.wikidataId,
    this.countryCode,
    this.countryCodeAlpha3,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    mapboxId: json["mapbox_id"],
    name: json["name"],
    wikidataId: json["wikidata_id"],
    countryCode: json["country_code"],
    countryCodeAlpha3: json["country_code_alpha_3"],
  );

  Map<String, dynamic> toJson() => {
    "mapbox_id": mapboxId,
    "name": name,
    "wikidata_id": wikidataId,
    "country_code": countryCode,
    "country_code_alpha_3": countryCodeAlpha3,
  };
}

class LocalityModel extends LocalityEntity {
  final String? mapboxId;
  final String? name;
  final String? wikidataId;

  LocalityModel({
    this.mapboxId,
    this.name,
    this.wikidataId,
  });

  factory LocalityModel.fromJson(Map<String, dynamic> json) => LocalityModel(
    mapboxId: json["mapbox_id"],
    name: json["name"],
    wikidataId: json["wikidata_id"],
  );

  Map<String, dynamic> toJson() => {
    "mapbox_id": mapboxId,
    "name": name,
    "wikidata_id": wikidataId,
  };
}

class RegionModel extends RegiontEntity {
  final String? mapboxId;
  final String? name;
  final String? wikidataId;
  final String? regionCode;
  final String? regionCodeFull;

  RegionModel({
    this.mapboxId,
    this.name,
    this.wikidataId,
    this.regionCode,
    this.regionCodeFull,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
    mapboxId: json["mapbox_id"],
    name: json["name"],
    wikidataId: json["wikidata_id"],
    regionCode: json["region_code"],
    regionCodeFull: json["region_code_full"],
  );

  Map<String, dynamic> toJson() => {
    "mapbox_id": mapboxId,
    "name": name,
    "wikidata_id": wikidataId,
    "region_code": regionCode,
    "region_code_full": regionCodeFull,
  };
}

class CoordinatesModel extends CoordinatesEntity {
  final double? longitude;
  final double? latitude;

  CoordinatesModel({
    this.longitude,
    this.latitude,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) => CoordinatesModel(
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "longitude": longitude,
    "latitude": latitude,
  };
}