import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/katalog_models.dart';

class PhotographerItemCard extends StatelessWidget {
  final PhotographerModel photographer;

  const PhotographerItemCard({
    super.key,
    required this.photographer,
  });

  Future<void> _openInstagram(BuildContext context) async {
    final Uri url = Uri.parse(photographer.igLink);
    try {
      final launched = await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak dapat membuka tautan Instagram.'),
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
          // Header: Avatar + Username & Title
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.forest,
                  border: Border.all(
                    color: AppColors.sageBorder,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    photographer.avatarInitials ??
                        (photographer.username.length > 2
                            ? photographer.username.substring(1, 3).toUpperCase()
                            : 'PH'),
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      photographer.username,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.forest,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      photographer.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Row of 3 Square Images
          Row(
            children: photographer.imageUrls.take(3).map((url) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            color: const Color(0xFFE2EBE2),
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF385E43), Color(0xFF1B3B2B)],
                              ),
                            ),
                            child: const Icon(
                              Icons.photo_camera_rounded,
                              color: Colors.white70,
                              size: 26,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 14),

          // Description Text
          Text(
            photographer.description,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.45,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 14),

          // Button: "Lihat Instagram" with Open In New Icon
          GestureDetector(
            onTap: () => _openInstagram(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color: AppColors.sageLight.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.sageBorder,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Lihat Instagram',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.forest,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.open_in_new_rounded,
                    size: 15,
                    color: AppColors.forest,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
