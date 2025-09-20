import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:geolocator/geolocator.dart';

class LocationManager {

  static Future<void> _checkServiceEnabled() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception(AppLocalizations().locationServicesAreDisabled);
    }
  }

  static Future<void> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception(AppLocalizations().locationPermissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(AppLocalizations().locationPermissionPermanentlyDenied);
    }
  }

  static Future<Position> getCurrentLocation() async {
    await _checkServiceEnabled();
    await _checkPermission();
    return await Geolocator.getCurrentPosition();
  }
}

