import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../app/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bedengan Xplore', style: AppTypography.heading3.copyWith(color: AppColors.primary)),
                    const SizedBox(height: 32),
                    Text('Jelajahi Bedengan,\nTemukan Tempat Favoritmu', style: AppTypography.display),
                    const SizedBox(height: 16),
                    Text(
                      'Panduan untuk mengenal kawasan, menjelajahi zona ground camping, memahami denah ruang spasial, dan menemukan spot menarik di bumi perkemahan Bedengan Malang.',
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.camping);
                        },
                        child: const Text('Jelajahi Ground Camping'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.guide);
                        },
                        child: const Text('Panduan & Tata Tertib Pengunjung'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('Seputar Informasi', style: AppTypography.heading2),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    _buildInfoCard(
                      context,
                      'Katalog Kawasan',
                      Icons.storefront,
                      AppRoutes.main, // Or catalog
                    ),
                    _buildInfoCard(
                      context,
                      'Ground Camping',
                      Icons.park,
                      AppRoutes.camping,
                    ),
                    _buildInfoCard(
                      context,
                      'Panduan',
                      Icons.menu_book,
                      AppRoutes.guide,
                    ),
                    _buildInfoCard(
                      context,
                      'Tanya AI',
                      Icons.auto_awesome,
                      AppRoutes.main, // Or ai
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        if (route == AppRoutes.main) {
          // just placeholder if it's the main route we let bottom nav handle it for now
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            Text(title, style: AppTypography.heading3.copyWith(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
