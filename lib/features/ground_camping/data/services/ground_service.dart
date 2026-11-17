import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_config.dart';
import '../models/ground_model.dart';

class GroundService {
  /// Mengambil daftar seluruh zona perkemahan (Ground A - M) dari backend API
  /// Endpoint: GET /api/grounds
  Future<List<GroundModel>> fetchGrounds() async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/grounds');
      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final dynamic rawData = jsonResponse['data'];

        List<dynamic> groundsList = [];
        if (rawData is Map<String, dynamic> && rawData['grounds'] is List) {
          groundsList = rawData['grounds'];
        } else if (rawData is List) {
          groundsList = rawData;
        }

        if (groundsList.isNotEmpty) {
          return groundsList
              .whereType<Map<String, dynamic>>()
              .map((item) => GroundModel.fromJson(item))
              .toList();
        }
      }
    } catch (_) {
      // Fallback diam-diam ke dataset lokal jika offline atau terjadi gangguan jaringan
    }

    // Mengembalikan dataset resmi jika backend tidak terjangkau
    return dummyGrounds;
  }
}

