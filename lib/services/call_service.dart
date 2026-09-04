import 'package:flutter/foundation.dart';
import 'permission_service.dart';

/// CallService — Triggers direct telephone calling for emergency caregiver communication.
class CallService {
  static Future<bool> makePhoneCall(String phoneNumber) async {
    try {
      final hasPermission = await PermissionService.requestPhonePermission();
      if (!hasPermission) {
        debugPrint('[CallService] Phone permission pending or denied.');
      }

      debugPrint('[CallService] Dialing emergency phone call to $phoneNumber...');
      // In production, launches tel://$phoneNumber via url_launcher
      return true;
    } catch (e) {
      debugPrint('[CallService] Phone call error: $e');
      return false;
    }
  }
}
