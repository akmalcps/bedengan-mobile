import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
          // Title
          Text(
            rental.name,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.forest,
            ),
          ),

          const SizedBox(height: 4),

          // Description
          Text(
            rental.description,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 14),

          // 2x2 Grid of Rental Items
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: rental.items.map((item) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  // Make each cell take roughly half the width minus spacing
                  final itemWidth = (MediaQuery.of(context).size.width - 40 - 32 - 10) / 2;
                  return Container(
                    width: itemWidth,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F7EE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.sageBorder.withValues(alpha: 0.7),
                        width: 0.8,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'] ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.forest,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['price'] ?? '',
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 14),

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
