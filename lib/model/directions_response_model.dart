import 'dart:convert';

import 'package:mapbox_implementation/entities/directions_response_entity.dart';

DirectionsResponseModel directionsResponseModelFromJson(String str) => DirectionsResponseModel.fromJson(json.decode(str));

String directionsResponseModelToJson(DirectionsResponseModel data) => json.encode(data.toJson());

class DirectionsResponseModel extends DirectionsResponseEntity {
  final List<RouteModel>? routes;
  final List<WaypointModel>? waypoints;
  final String? code;
  final String? uuid;

  DirectionsResponseModel({
    this.routes,
    this.waypoints,
    this.code,
    this.uuid,
  });

  factory DirectionsResponseModel.fromJson(Map<String, dynamic> json) => DirectionsResponseModel(
    routes: json["routes"] == null ? [] : List<RouteModel>.from(json["routes"]!.map((x) => RouteModel.fromJson(x))),
    waypoints: json["waypoints"] == null ? [] : List<WaypointModel>.from(json["waypoints"]!.map((x) => WaypointModel.fromJson(x))),
    code: json["code"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "routes": routes == null ? [] : List<dynamic>.from(routes!.map((x) => x.toJson())),
    "waypoints": waypoints == null ? [] : List<dynamic>.from(waypoints!.map((x) => x.toJson())),
    "code": code,
    "uuid": uuid,
  };
}

class RouteModel extends Route {
  final String? weightName;
  final double? weight;
  final double? duration;
  final double? distance;
  final List<LegModel>? legs;
  final String? geometry;

  RouteModel({
    this.weightName,
    this.weight,
    this.duration,
    this.distance,
    this.legs,
    this.geometry,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
    weightName: json["weight_name"],
    weight: json["weight"]?.toDouble(),
    duration: json["duration"]?.toDouble(),
    distance: json["distance"]?.toDouble(),
    legs: json["legs"] == null ? [] : List<LegModel>.from(json["legs"]!.map((x) => LegModel.fromJson(x))),
    geometry: json["geometry"],
  );

  Map<String, dynamic> toJson() => {
    "weight_name": weightName,
    "weight": weight,
    "duration": duration,
    "distance": distance,
    "legs": legs == null ? [] : List<dynamic>.from(legs!.map((x) => x.toJson())),
    "geometry": geometry,
  };
}

class LegModel extends Leg {
  final List<NotificationModel>? notifications;
  final List<dynamic>? viaWaypoints;
  final double? weight;
  final double? duration;
  final SirnsModel? sirns;
  final List<dynamic>? steps;
  final double? distance;
  final String? summary;

  LegModel({
    this.notifications,
    this.viaWaypoints,
    this.weight,
    this.duration,
    this.sirns,
    this.steps,
    this.distance,
    this.summary,
  });

  factory LegModel.fromJson(Map<String, dynamic> json) => LegModel(
    notifications: json["notifications"] == null ? [] : List<NotificationModel>.from(json["notifications"]!.map((x) => NotificationModel.fromJson(x))),
    viaWaypoints: json["via_waypoints"] == null ? [] : List<dynamic>.from(json["via_waypoints"]!.map((x) => x)),
    weight: json["weight"]?.toDouble(),
    duration: json["duration"]?.toDouble(),
    sirns: json["sirns"] == null ? null : SirnsModel.fromJson(json["sirns"]),
    steps: json["steps"] == null ? [] : List<dynamic>.from(json["steps"]!.map((x) => x)),
    distance: json["distance"]?.toDouble(),
    summary: json["summary"],
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    "via_waypoints": viaWaypoints == null ? [] : List<dynamic>.from(viaWaypoints!.map((x) => x)),
    "weight": weight,
    "duration": duration,
    "sirns": sirns?.toJson(),
    "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x)),
    "distance": distance,
    "summary": summary,
  };
}

class NotificationModel extends Notification {
  final DetailsModel? details;
  final int? geometryIndexEnd;
  final int? geometryIndexStart;

  NotificationModel({
    this.details,
    this.geometryIndexEnd,
    this.geometryIndexStart,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    details: json["details"] == null ? null : DetailsModel.fromJson(json["details"]),
    geometryIndexEnd: json["geometry_index_end"],
    geometryIndexStart: json["geometry_index_start"],
  );

  Map<String, dynamic> toJson() => {
    "details": details?.toJson(),
    "geometry_index_end": geometryIndexEnd,
    "geometry_index_start": geometryIndexStart,
  };
}

class DetailsModel extends Details {
  final String? actualValue;
  final String? message;

  DetailsModel({
    this.actualValue,
    this.message,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
    actualValue: json["actual_value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "actual_value": actualValue,
    "message": message,
  };
}

enum SubtypeModel {
  STATE_BORDER_CROSSING
}

final subtypeValues = EnumValues({
  "stateBorderCrossing": SubtypeModel.STATE_BORDER_CROSSING
});

class SirnsModel extends Sirns {
  SirnsModel();

  factory SirnsModel.fromJson(Map<String, dynamic> json) => SirnsModel(
  );

  Map<String, dynamic> toJson() => {
  };
}

class WaypointModel extends Waypoint {
  final double? distance;
  final String? name;
  final List<double>? location;

  WaypointModel({
    this.distance,
    this.name,
    this.location,
  });

  factory WaypointModel.fromJson(Map<String, dynamic> json) => WaypointModel(
    distance: json["distance"]?.toDouble(),
    name: json["name"],
    location: json["location"] == null ? [] : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "name": name,
    "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}