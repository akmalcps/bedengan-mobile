import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../ground_camping/presentation/screens/ground_camping_screen.dart';
import '../../../panduan/presentation/screens/panduan_screen.dart';

class InfoCardsSection extends StatelessWidget {
  const InfoCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Seputar Informasi',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.forest,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Card 1: Informasi -> PanduanScreen
              Expanded(
                child: _buildCard(
                  icon: Icons.photo_library_outlined,
                  title: 'Informasi',
                  desc: 'Etika alam dan aturan berkemah.',
                  actionText: 'Selengkapnya',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PanduanScreen(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 14),
              // Card 2: Ground -> GroundCampingScreen
              Expanded(
                child: _buildCard(
                  icon: Icons.area_chart_outlined,
                  title: 'Ground',
                  desc: 'Ground dari Zona A hingga Zona F.',
                  actionText: 'Peta Zona',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GroundCampingScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String desc,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.sageBorder.withValues(alpha: 0.6),
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
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: AppColors.forest,
                size: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.forest,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              desc,
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  actionText,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 11,
                  color: AppColors.primaryDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
