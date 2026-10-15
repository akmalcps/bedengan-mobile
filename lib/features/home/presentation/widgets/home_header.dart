import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const HomeHeader({
    super.key,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Tombol back akan muncul jika Navigator bisa pop atau dipaksa via showBackButton
    final canPop = showBackButton || Navigator.canPop(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sisi Kiri: Tombol Back / Spacing
          if (canPop)
            GestureDetector(
              onTap: onBackPressed ?? () => Navigator.maybePop(context),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.chevron_left_rounded,
                  size: 28,
                  color: AppColors.forest,
                ),
              ),
            )
          else
            const SizedBox(width: 40), // Penyeimbang tata letak kiri
          // Sisi Tengah: Logo App
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.appLogo,
                height: 28,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.terrain, color: AppColors.primary),
              ),
              const SizedBox(width: 8),
              const Text(
                'BEDENGAN ',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: AppColors.forest,
                ),
              ),
              const Text(
                'XPLORE',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          // Sisi Kanan: Spacing Penyeimbang agar Logo Tetap di Tengah
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
