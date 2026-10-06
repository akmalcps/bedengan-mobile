import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.main);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.park, size: 80, color: AppColors.primary),
            const SizedBox(height: 16),
            Text('Bedengan Xplore', style: AppTypography.display),
            const SizedBox(height: 8),
            Text('Frictionless Local Ecosystem', style: AppTypography.bodyMedium),
          ],
        ),
      ),
    );
  }
}
