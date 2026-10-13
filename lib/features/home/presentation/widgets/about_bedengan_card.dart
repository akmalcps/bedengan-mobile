import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AboutBedenganCard extends StatelessWidget {
  const AboutBedenganCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          const Text(
            'SEKILAS KAWASAN',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tentang Wisata Bedengan',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.forest,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(20),
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
                  blurRadius: 14,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Text(
              'Bumi Perkemahan Bedengan adalah destinasi wisata alam dan camping ground favorit di lereng Gunung Kawi, Dau, Malang. Dikelilingi hutan pinus yang asri, udara pegunungan yang sejuk, serta aliran sungai jernih berbatu alami, Bedengan menjadi tempat sempurna untuk melepas penat, berkemah bersama keluarga, mmenikmati keindahan alam terbuka.',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: AppColors.forestMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
