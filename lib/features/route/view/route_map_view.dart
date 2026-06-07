import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteMapView extends StatelessWidget {
  final double markInLat;
  final double markInLng;
  final double markOutLat;
  final double markOutLng;

  const RouteMapView({
    super.key,
    required this.markInLat,
    required this.markInLng,
    required this.markOutLat,
    required this.markOutLng,
  });

  @override
  Widget build(BuildContext context) {
    final markIn = LatLng(markInLat, markInLng);
    final markOut = LatLng(markOutLat, markOutLng);

    return Scaffold(
      appBar: AppBar(title: const Text("Route Map")),
      body: FlutterMap(
        options: MapOptions(initialCenter: markIn, initialZoom: 16),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.attendance_app',
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: markIn,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 40,
                ),
              ),

              Marker(
                point: markOut,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),

          PolylineLayer(
            polylines: [
              Polyline(points: [markIn, markOut], strokeWidth: 4),
            ],
          ),
        ],
      ),
    );
  }
}
