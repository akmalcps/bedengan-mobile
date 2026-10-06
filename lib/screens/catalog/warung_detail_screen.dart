import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';
import '../../theme/app_colors.dart';
import '../../data/mock/warung_mock.dart';
import '../../widgets/common/app_image.dart';
import '../../utils/url_utils.dart';

class WarungDetailScreen extends StatelessWidget {
  final String warungId;

  const WarungDetailScreen({super.key, required this.warungId});

  @override
  Widget build(BuildContext context) {
    final warung = WarungMockData.warungs.firstWhere((e) => e.id == warungId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(warung.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              url: warung.image,
              height: 200,
              width: double.infinity,
              borderRadius: BorderRadius.circular(20),
            ),
            const SizedBox(height: 24),
            Text(warung.name, style: AppTypography.heading1),
            const SizedBox(height: 8),
            Text('Jam Operasional: ${warung.openingTime} - ${warung.closingTime}', style: AppTypography.bodySmall),
            const SizedBox(height: 16),
            Text(warung.description, style: AppTypography.bodyMedium),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: warung.tags.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(tag, style: AppTypography.bodySmall.copyWith(color: AppColors.primary)),
              )).toList(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  UrlUtils.launchWhatsApp(warung.whatsapp, text: 'Halo, saya ingin memesan di ${warung.name}');
                },
                icon: const Icon(Icons.chat),
                label: const Text('Hubungi WA'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
