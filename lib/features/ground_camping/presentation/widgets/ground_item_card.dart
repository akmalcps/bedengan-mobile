import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../data/models/ground_model.dart';

class GroundItemCard extends StatelessWidget {
  final GroundModel ground;

  const GroundItemCard({
    super.key,
    required this.ground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section: Image with Stack Badges
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 190,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildGroundImage(),

                    // Top-Left Badge: Ground Name (Green Badge)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          ground.name,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                            color: AppColors.forest,
                          ),
                        ),
                      ),
                    ),

                    // Bottom-Left Badge: Capacity (Dark Semi-transparent Badge)
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          ground.capacity,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Middle Section: Description Text
            Text(
              ground.description,
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.45,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 14),

            // Specs Section: 2x2 Grid with Light Grey/Sage Background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAF5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.sageBorder.withValues(alpha: 0.6),
                  width: 0.8,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildSpecItem(
                          icon: ground.areaIcon ?? Icons.square_foot_rounded,
                          iconColor: const Color(0xFF64748B),
                          text: ground.areaSize,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildSpecItem(
                          icon: ground.terrainIcon ?? Icons.eco_rounded,
                          iconColor: const Color(0xFF16A34A),
                          text: ground.terrainType,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSpecItem(
                          icon: ground.facility1Icon ?? Icons.bolt_rounded,
                          iconColor: const Color(0xFFD97706),
                          text: ground.facility1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildSpecItem(
                          icon: ground.facility2Icon ?? Icons.wc_rounded,
                          iconColor: const Color(0xFF0284C7),
                          text: ground.facility2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Bottom Section: Highlight Chip/Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: ground.highlightBadgeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ground.highlightBadgeColor.withValues(alpha: 0.3),
                  width: 0.8,
                ),
              ),
              child: Text(
                ground.highlightBadgeText,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ground.highlightBadgeColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecItem({
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.forest,
            ),
          ),
        ),
      ],
    );
  }

  /// Membangun widget gambar utama menggunakan properti image_url dari GroundModel
  /// Dilengkapi loading indicator dan fallback aman ke asset lokal
  Widget _buildGroundImage() {
    final url = ground.image_url.trim();
    final bool hasValidNetworkUrl = url.isNotEmpty &&
        (url.startsWith('http://') || url.startsWith('https://'));

    // Fallback aman: jika image_url bernilai null atau string kosong / bukan link internet
    if (!hasValidNetworkUrl) {
      return _buildAssetFallback();
    }

    // Render gambar via Image.network dengan indikator loading saat gambar dari internet ditarik
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        final expected = progress.expectedTotalBytes;
        final loaded = progress.cumulativeBytesLoaded;
        final double? progressVal = (expected != null && expected > 0)
            ? loaded / expected
            : null;
        return Container(
          color: const Color(0xFF2C4331),
          child: Center(
            child: CircularProgressIndicator(
              value: progressVal,
              color: AppColors.primary,
              strokeWidth: 2,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // Fallback jika koneksi internet terputus atau gambar 404
        return _buildAssetFallback();
      },
    );
  }

  /// Fallback aman: merender gambar dummy lokal dari assets
  Widget _buildAssetFallback() {
    return Image.asset(
      AppAssets.mapPreview,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF385E43), Color(0xFF1B3B2B)],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.forest_rounded,
                  color: Colors.white70,
                  size: 44,
                ),
                const SizedBox(height: 6),
                Text(
                  ground.name,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
