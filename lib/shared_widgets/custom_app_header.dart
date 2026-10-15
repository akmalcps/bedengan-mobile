import 'package:flutter/material.dart';

class CustomAppHeader extends StatelessWidget {
  const CustomAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F4EC),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16, // SafeArea padding
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/app_logo.png',
            height: 24,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.terrain,
              color: Color(0xFF8BBE45),
            ), // Fallback jika gambar gagal dimuat
          ),
          const SizedBox(width: 8),
          const Text(
            'BEDENGAN',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E3A2B),
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'XPLORE',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF8BBE45),
            ),
          ),
        ],
      ),
    );
  }
}
