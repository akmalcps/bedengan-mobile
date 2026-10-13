import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../ground_camping/presentation/screens/ground_camping_screen.dart';
import '../../../panduan/presentation/screens/panduan_screen.dart';

class HomeHeroButtons extends StatelessWidget {
  const HomeHeroButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          // Pine tree watermark in background
          Positioned(
            right: 0,
            top: 20,
            child: Opacity(
              opacity: 0.12,
              child: Row(
                children: const [
                  Icon(Icons.park_rounded, size: 70, color: AppColors.forest),
                  Icon(Icons.park_rounded, size: 50, color: AppColors.forest),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Text(
                'Jelajahi Bedengan,\nTemukan Tempat\nFavoritmu',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  color: AppColors.forest,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Panduan untuk mengenal kawasan, menjelajahi zona ground camping, memahami denah ruang spasial, dan menemukan spot menarik di bumi perkemahan Bedengan Malang.',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 22),

              // Button 1: Jelajahi Ground Camping
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.forest,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GroundCampingScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.cabin_rounded, color: AppColors.forest, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Jelajahi Ground Camping',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.forest,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Button 2: Panduan & Tata Tertib Pengunjung
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.sageLight,
                    foregroundColor: AppColors.forest,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PanduanScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.menu_book_rounded, color: AppColors.forest, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Panduan & Tata Tertib Pengunjung',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.forest,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
