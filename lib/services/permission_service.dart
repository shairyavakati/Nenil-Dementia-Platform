import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

/// PermissionService — Handles runtime permission requests for mic, location, and phone calling.
class PermissionService {
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    debugPrint('[PermissionService] Microphone status: $status');
    return status.isGranted;
  }

  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    debugPrint('[PermissionService] Location status: $status');
    return status.isGranted;
  }

  static Future<bool> requestPhonePermission() async {
    final status = await Permission.phone.request();
    debugPrint('[PermissionService] Phone call status: $status');
    return status.isGranted;
  }
}
