import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlUtils {
  static Future<void> launchWhatsApp(String phone, {String? text}) async {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    final whatsappUrl = Uri.parse('https://wa.me/$cleanPhone${text != null ? '?text=${Uri.encodeComponent(text)}' : ''}');
    
    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Could not launch WhatsApp: $e');
    }
  }

  static Future<void> launchInstagram(String url) async {
    final igUrl = Uri.parse(url);
    try {
      if (await canLaunchUrl(igUrl)) {
        await launchUrl(igUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Could not launch Instagram: $e');
    }
  }
}
