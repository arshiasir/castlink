import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class PlatformPip {
  static const MethodChannel _channel = MethodChannel('com.castlink/pip');

  static Future<bool> isPipSupported() async {
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        final bool isSupported = await _channel.invokeMethod('isPipAvailable');
        return isSupported;
      } catch (e) {
        print('Error checking PiP support: $e');
        return false;
      }
    }
    return false;
  }

  static Future<void> enterPip() async {
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        await _channel.invokeMethod('enterPip');
      } catch (e) {
        print('Error entering PiP mode: $e');
        rethrow;
      }
    }
  }

  static Future<void> exitPip() async {
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        await _channel.invokeMethod('exitPip');
      } catch (e) {
        print('Error exiting PiP mode: $e');
        rethrow;
      }
    }
  }
} 