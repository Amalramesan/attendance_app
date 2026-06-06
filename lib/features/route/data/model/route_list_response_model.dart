class RouteListResponse {
  final bool status;
  final String message;
  final List<RouteItem> routeList;

  RouteListResponse({
    required this.status,
    required this.message,
    required this.routeList,
  });

  factory RouteListResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return RouteListResponse(
      status: json['status'],
      message: json['message'],
      routeList:
          (json['route_list'] as List)
              .map(
                (e) => RouteItem.fromJson(e),
              )
              .toList(),
    );
  }
}

class RouteItem {
  final String date;
  final String markIn;
  final String markOut;
  final Location markInLocation;
  final Location markOutLocation;

  RouteItem({
    required this.date,
    required this.markIn,
    required this.markOut,
    required this.markInLocation,
    required this.markOutLocation,
  });

  factory RouteItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return RouteItem(
      date: json['date'],
      markIn: json['mark_in'],
      markOut: json['mark_out'],
      markInLocation: Location.fromJson(
        json['mark_in_location'],
      ),
      markOutLocation: Location.fromJson(
        json['mark_out_location'],
      ),
    );
  }
}

class Location {
  final String latitude;
  final String longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(
    Map<String, dynamic> json,
  ) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}