import 'dart:convert';
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../../core/constants/api_config.dart';

class KatalogService {
  /// Mengirim pengajuan pendaftaran mitra UMKM / Vendor baru ke Backend Bedengan Xplore
  /// Endpoint: POST /api/catalogs/apply (multipart/form-data)
  Future<Map<String, dynamic>> applyVendor({
    required String category, // 'warung', 'rental', 'photographer'
    required String name,
    required String applicantName,
    required String whatsapp,
    String? instagram,
    String? description,
    String? operatingHours,
    String? locationNote,
    String? priceText,
    List<String>? tags,
    String? imagePath,
    List<int>? imageBytes,
    String? imageName,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/catalogs/apply');
      final request = http.MultipartRequest('POST', uri);

      // ── 1. Field Teks Form ──
      request.fields['category'] = category;
      request.fields['name'] = name.trim();
      request.fields['applicant_name'] = applicantName.trim();
      request.fields['contact_phone'] = whatsapp.trim();

      if (instagram != null && instagram.trim().isNotEmpty) {
        request.fields['social_handle'] = instagram.trim();
      }
      if (description != null && description.trim().isNotEmpty) {
        request.fields['description'] = description.trim();
      }
      if (operatingHours != null && operatingHours.trim().isNotEmpty) {
        request.fields['operating_hours'] = operatingHours.trim();
      }
      if (locationNote != null && locationNote.trim().isNotEmpty) {
        request.fields['location_note'] = locationNote.trim();
      }
      if (priceText != null && priceText.trim().isNotEmpty) {
        request.fields['price_text'] = priceText.trim();
      }
      if (tags != null && tags.isNotEmpty) {
        request.fields['tags'] = tags.join(', ');
      }

      // ── 2. Lampiran File Foto (Key: 'image' sesuai multer single('image')) ──
      // Prioritas 1: Gunakan imageBytes jika tersedia (paling reliable di seluruh OS & Android scoped storage)
      if (imageBytes != null && imageBytes.isNotEmpty) {
        String cleanName = imageName ?? 'upload_${DateTime.now().millisecondsSinceEpoch}.jpg';
        if (!cleanName.contains('.')) cleanName = '$cleanName.jpg';
        final ext = cleanName.split('.').last.toLowerCase();
        final mimeSubtype = (ext == 'png')
            ? 'png'
            : (ext == 'webp' ? 'webp' : 'jpeg');

        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageBytes,
            filename: cleanName,
            contentType: MediaType('image', mimeSubtype),
          ),
        );
      }
      // Prioritas 2: Gunakan imagePath jika ada dan file ada di disk
      else if (imagePath != null && imagePath.isNotEmpty && !kIsWeb) {
        final file = File(imagePath);
        if (await file.exists()) {
          String cleanName = imageName ?? imagePath.split(RegExp(r'[/\\]')).last;
          if (!cleanName.contains('.')) cleanName = '$cleanName.jpg';
          final ext = cleanName.split('.').last.toLowerCase();
          final mimeSubtype = (ext == 'png')
              ? 'png'
              : (ext == 'webp' ? 'webp' : 'jpeg');

          request.files.add(
            await http.MultipartFile.fromPath(
              'image',
              imagePath,
              filename: cleanName,
              contentType: MediaType('image', mimeSubtype),
            ),
          );
        }
      }

      // ── 3. Pengiriman Request ──
      final streamedResponse =
          await request.send().timeout(const Duration(seconds: 30));
      final response = await http.Response.fromStream(streamedResponse);

      Map<String, dynamic> jsonResponse = {};
      try {
        jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      } catch (_) {
        jsonResponse = {
          'message': response.body.isNotEmpty
              ? response.body
              : 'Status response: ${response.statusCode}'
        };
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': jsonResponse['message'] ?? 'Pendaftaran berhasil dikirim!',
          'data': jsonResponse['data'],
        };
      } else {
        final errMsg = jsonResponse['message'] ??
            jsonResponse['error'] ??
            'Gagal mengirim pendaftaran (HTTP ${response.statusCode})';
        throw Exception(errMsg);
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Kendala koneksi: $e');
    }
  }

  /// Mendapatkan daftar katalog yang sudah disetujui (status=approved) dari backend
  Future<List<dynamic>> fetchCatalogs({String? category}) async {
    try {
      Uri uri;
      if (category != null && category.isNotEmpty && category != 'semua') {
        uri = Uri.parse(
          '${ApiConfig.baseUrl}/catalogs?status=approved&category=$category',
        );
      } else {
        uri = Uri.parse('${ApiConfig.baseUrl}/catalogs?status=approved');
      }

      final response = await http.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final rawData = jsonResponse['data'];
        if (rawData is List) {
          return rawData;
        }
        return [];
      } else {
        throw Exception('Gagal memuat katalog (HTTP ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Koneksi katalog error: $e');
    }
  }
}
