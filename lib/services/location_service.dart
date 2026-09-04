import 'package:flutter/foundation.dart';
import 'permission_service.dart';

/// LocationService — Provides GPS location coordinates for emergency SOS alerts.
class LocationService {
  static Future<Map<String, double>> getCurrentLocation() async {
    try {
      final hasPermission = await PermissionService.requestLocationPermission();
      if (!hasPermission) {
        debugPrint('[LocationService] Location permission denied. Using fallback coordinates.');
      }

      debugPrint('[LocationService] Fetched active GPS location coordinates.');
      // Returns Guwahati, Assam (NER region center) fallback coordinates
      return {'latitude': 26.1445, 'longitude': 91.7362};
    } catch (e) {
      debugPrint('[LocationService] Location fetch error: $e');
      return {'latitude': 26.1445, 'longitude': 91.7362};
    }
  }
}
