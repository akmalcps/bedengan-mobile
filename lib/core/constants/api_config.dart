import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConfig {
  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:5000/api';
    if (Platform.isAndroid) return 'http://10.0.2.2:5000/api';
    return 'http://localhost:5000/api';
  }

  static String get baseImageUrl {
    if (kIsWeb) return 'http://localhost:5000';
    if (Platform.isAndroid) return 'http://10.0.2.2:5000';
    return 'http://localhost:5000';
  }

  /// Helper to resolve image URLs returned by the server (e.g., replace localhost with 10.0.2.2 on Android)
  static String resolveImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (!kIsWeb && Platform.isAndroid && url.contains('localhost:5000')) {
      return url.replaceAll('localhost:5000', '10.0.2.2:5000');
    }
    if (!kIsWeb && Platform.isAndroid && url.contains('127.0.0.1:5000')) {
      return url.replaceAll('127.0.0.1:5000', '10.0.2.2:5000');
    }
    if (url.startsWith('/')) {
      return '$baseImageUrl$url';
    }
    return url;
  }
}

