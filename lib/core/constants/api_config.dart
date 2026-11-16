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

  static String resolveImageUrl(String path) {
    if (path.isEmpty) return '';
    
    // CEK CLOUDINARY: Jika URL sudah berawalan http/https dari internet, 
    // langsung kembalikan apa adanya (jangan ditimpa localhost)
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    
    // CEK LOKAL: Jika URL dari folder lokal backend (/uploads/...), 
    // tambahkan baseUrl agar bisa diakses emulator
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    return '$baseUrl$path';
  }
}

