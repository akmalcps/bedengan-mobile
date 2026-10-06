import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';
import '../../theme/app_colors.dart';
import '../../data/mock/photographer_mock.dart';
import '../../widgets/common/app_image.dart';
import '../../utils/url_utils.dart';

class PhotographerDetailScreen extends StatelessWidget {
  final String photographerId;

  const PhotographerDetailScreen({super.key, required this.photographerId});

  @override
  Widget build(BuildContext context) {
    final photographer = PhotographerMockData.photographers.firstWhere((e) => e.id == photographerId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(photographer.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  AppImage(
                    url: photographer.profileImage,
                    height: 120,
                    width: 120,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  const SizedBox(height: 16),
                  Text(photographer.name, style: AppTypography.heading1),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => UrlUtils.launchInstagram(photographer.instagramUrl),
                    child: Text(photographer.instagramUsername, style: AppTypography.bodyMedium.copyWith(color: AppColors.primary)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(photographer.description, style: AppTypography.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            Text('Layanan', style: AppTypography.heading3),
            const SizedBox(height: 16),
            ...photographer.services.map((service) => Card(
              elevation: 0,
              color: AppColors.white,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(service.name, style: AppTypography.heading3),
                    const SizedBox(height: 4),
                    Text(service.description, style: AppTypography.bodySmall),
                    const SizedBox(height: 8),
                    Text('Mulai Rp${service.startingPrice}', style: AppTypography.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 24),
            Text('Galeri', style: AppTypography.heading3),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: photographer.gallery.length,
              itemBuilder: (context, index) {
                return AppImage(
                  url: photographer.gallery[index],
                  borderRadius: BorderRadius.circular(8),
                );
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  UrlUtils.launchWhatsApp(photographer.whatsapp, text: 'Halo ${photographer.name}, saya ingin berdiskusi mengenai sesi foto.');
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
