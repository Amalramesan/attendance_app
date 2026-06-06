import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    
  }
  Future<String> getPlaceName(
  double latitude,
  double longitude,
) async {
  final placemarks =
      await placemarkFromCoordinates(
        latitude,
        longitude,
      );

  final place = placemarks.first;

  return "${place.locality}, ${place.administrativeArea}";
}
}
