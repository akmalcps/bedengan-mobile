import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/katalog_models.dart';

class WarungItemCard extends StatelessWidget {
  final WarungModel warung;

  const WarungItemCard({
    super.key,
    required this.warung,
  });

  Future<void> _openWhatsApp(BuildContext context) async {
    final Uri url = Uri.parse(warung.waLink);
    try {
      final launched = await launchUrl(url, mode: LaunchMode.externalApplication);
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
          // Row: Title & Time Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  warung.name,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.forest,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.sageLight.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  warung.time,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Description
          Text(
            warung.description,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.4,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 12),

          // Menu Chips (Wrap)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: warung.menus.map((menu) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F6F2),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: AppColors.sageBorder.withValues(alpha: 0.6),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  menu,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.forest,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

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
