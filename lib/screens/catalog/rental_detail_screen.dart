import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';
import '../../theme/app_colors.dart';
import '../../data/mock/rental_mock.dart';
import '../../widgets/common/app_image.dart';
import '../../utils/url_utils.dart';

class RentalDetailScreen extends StatelessWidget {
  final String rentalId;

  const RentalDetailScreen({super.key, required this.rentalId});

  @override
  Widget build(BuildContext context) {
    final rental = RentalMockData.rentals.firstWhere((e) => e.id == rentalId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(rental.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              url: rental.image,
              height: 200,
              width: double.infinity,
              borderRadius: BorderRadius.circular(20),
            ),
            const SizedBox(height: 24),
            Text(rental.name, style: AppTypography.heading1),
            const SizedBox(height: 8),
            Text('Jam Operasional: ${rental.openingTime} - ${rental.closingTime}', style: AppTypography.bodySmall),
            const SizedBox(height: 16),
            Text(rental.description, style: AppTypography.bodyMedium),
            const SizedBox(height: 24),
            Text('Daftar Alat', style: AppTypography.heading3),
            const SizedBox(height: 16),
            ...rental.items.map((item) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: AppImage(url: item.image, width: 60, height: 60, borderRadius: BorderRadius.circular(8)),
              title: Text(item.name, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              subtitle: Text('Rp${item.price} / ${item.unit}', style: AppTypography.bodySmall),
              trailing: Icon(item.availability ? Icons.check_circle : Icons.cancel, color: item.availability ? AppColors.primary : Colors.red),
            )),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  UrlUtils.launchWhatsApp(rental.whatsapp, text: 'Halo, saya ingin menyewa alat di ${rental.name}');
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
