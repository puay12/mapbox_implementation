import 'package:equatable/equatable.dart';

class DirectionsResponseEntity extends Equatable {
  final List<Route>? routes;
  final List<Waypoint>? waypoints;
  final String? code;
  final String? uuid;

  DirectionsResponseEntity({
    this.routes,
    this.waypoints,
    this.code,
    this.uuid,
  });

  @override
  List<Object?> get props {
    return [
      routes,
      waypoints,
      code,
      uuid,
    ];
  }

}

class Route extends Equatable {
  final String? weightName;
  final double? weight;
  final double? duration;
  final double? distance;
  final List<Leg>? legs;
  final String? geometry;

  Route({
    this.weightName,
    this.weight,
    this.duration,
    this.distance,
    this.legs,
    this.geometry,
  });

  @override
  List<Object?> get props {
    return [
      weightName,
      weight,
      duration,
      distance,
      legs,
      geometry,
    ];
  }

}

class Leg extends Equatable {
  final List<Notification>? notifications;
  final List<dynamic>? viaWaypoints;
  final List<Admin>? admins;
  final double? weight;
  final double? duration;
  final Sirns? sirns;
  final List<dynamic>? steps;
  final double? distance;
  final String? summary;

  Leg({
    this.notifications,
    this.viaWaypoints,
    this.admins,
    this.weight,
    this.duration,
    this.sirns,
    this.steps,
    this.distance,
    this.summary,
  });

  @override
  List<Object?> get props {
    return [
      notifications,
      viaWaypoints,
      admins,
      weight,
      duration,
      sirns,
      steps,
      distance,
      summary,
    ];
  }

}

class Admin extends Equatable {
  final Iso31661Alpha3? iso31661Alpha3;
  final Iso31661? iso31661;

  Admin({
    this.iso31661Alpha3,
    this.iso31661,
  });

  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      iso31661Alpha3,
      iso31661,
    ];
  }

}

enum Iso31661 {
  US
}

enum Iso31661Alpha3 {
  USA
}

class Notification extends Equatable {
  final Details? details;
  final Subtype? subtype;
  final Type? type;
  final int? geometryIndexEnd;
  final int? geometryIndexStart;

  Notification({
    this.details,
    this.subtype,
    this.type,
    this.geometryIndexEnd,
    this.geometryIndexStart,
  });

  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      details,
      subtype,
      type,
      geometryIndexEnd,
      geometryIndexStart,
    ];
  }

}

class Details extends Equatable {
  final String? actualValue;
  final String? message;

  Details({
    this.actualValue,
    this.message,
  });

  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      actualValue,
      message,
    ];
  }

}

enum Subtype {
  STATE_BORDER_CROSSING
}

enum Type {
  ALERT
}

class Sirns {
  Sirns();
}

class Waypoint extends Equatable{
  final double? distance;
  final String? name;
  final List<double>? location;

  Waypoint({
    this.distance,
    this.name,
    this.location,
  });

  @override
  List<Object?> get props {
    return [
      distance,
      name,
      location,
    ];
  }

}