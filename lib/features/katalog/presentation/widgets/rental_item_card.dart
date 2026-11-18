import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/katalog_models.dart';

class RentalItemCard extends StatelessWidget {
  final RentalModel rental;

  const RentalItemCard({
    super.key,
    required this.rental,
  });

  Future<void> _openWhatsApp(BuildContext context) async {
    final Uri url = Uri.parse(rental.waLink);
    try {
      final launched =
          await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak dapat membuka WhatsApp.'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      }
    }
  }

  /// 1. Widget Banner Rental (Cloudinary / Image.network dengan loading & fallback asset lokal)
  Widget _buildBannerImage() {
    final banner = rental.banner_url.trim();
    final bool hasValidUrl = banner.isNotEmpty &&
        (banner.startsWith('http://') || banner.startsWith('https://'));

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: hasValidUrl
            ? Image.network(
                banner,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  final expected = progress.expectedTotalBytes;
                  final loaded = progress.cumulativeBytesLoaded;
                  final double? progressVal = (expected != null && expected > 0)
                      ? loaded / expected
                      : null;
                  return Container(
                    color: const Color(0xFFE2EBE2),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: progressVal,
                        color: AppColors.primary,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    _buildAssetBannerFallback(),
              )
            : _buildAssetBannerFallback(),
      ),
    );
  }

  /// Fallback dummy lokal jika banner_url null/kosong atau gagal ditarik
  Widget _buildAssetBannerFallback() {
    return Image.asset(
      AppAssets.mapPreview,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFFDCEAD7),
          child: const Center(
            child: Icon(
              Icons.cabin_rounded,
              size: 44,
              color: AppColors.forest,
            ),
          ),
        );
      },
    );
  }

  /// 2. Widget Item Perlengkapan dengan slot gambar dummy 40x40 di sebelah kiri
  Widget _buildEquipmentItem(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.sageBorder.withValues(alpha: 0.8),
          width: 0.8,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Slot gambar dummy lokal 40x40 bersudut melengkung (ClipRRect radius 8)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(
                AppAssets.mapPreview,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.sageLight,
                    child: const Icon(
                      Icons.holiday_village_rounded,
                      size: 20,
                      color: AppColors.forest,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Nama Item (rata tengah vertikal terhadap gambar)
          Expanded(
            child: Text(
              item['name'] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: AppColors.forest,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.sageBorder.withValues(alpha: 0.7),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama Rental
          Text(
            rental.name,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.forest,
            ),
          ),

          const SizedBox(height: 10),

          // 1. Foto Banner Rental
          _buildBannerImage(),

          const SizedBox(height: 12),

          // Deskripsi Rental
          Text(
            rental.description,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 16),

          // Label Daftar Perlengkapan
          const Text(
            'Pilihan Perlengkapan Camping:',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.forest,
            ),
          ),

          const SizedBox(height: 10),

          // 2. Daftar Item Perlengkapan (Row dengan slot gambar di sebelah kiri)
          Column(
            children: rental.items
                .map((item) => _buildEquipmentItem(item))
                .toList(),
          ),

          const SizedBox(height: 8),

          // Action Button: "Hubungi WA >"
          GestureDetector(
            onTap: () => _openWhatsApp(context),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Hubungi WA',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.forest,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: AppColors.forest,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
