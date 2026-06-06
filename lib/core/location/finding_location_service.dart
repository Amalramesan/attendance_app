import 'package:geocoding/geocoding.dart';

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