import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Mountain & Tree Logo Symbol
          SizedBox(
            width: 38,
            height: 28,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 2,
                  right: 10,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.landscape_rounded,
                      size: 26,
                      color: AppColors.forest,
                    ),
                    Icon(
                      Icons.park_rounded,
                      size: 16,
                      color: AppColors.forest,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
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
    );
  }
}
