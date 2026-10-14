import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';

class WarningCard extends StatelessWidget {
  const WarningCard({super.key});

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse('https://wa.me/6285161191942');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFF5E6B8),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: const Color(0xFFD97706),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Flexible(
                      child: Text(
                        'PERINGATAN PENTING & KEHILANGAN BARANG',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF92400E),
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Harap diperhatikan oleh seluruh pengunjung campsite',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF92400E).withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Bullet Points
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bullet 1
                _buildBulletPoint(
                  title: 'Menjaga Barang Pribadi',
                  description:
                      'Setiap pengunjung wajib mengawasi dan menjaga barang bawaan/berharga masing-masing (dompet, gadget, perlengkapan outdoor). Pihak pengelola tidak bertanggung jawab atas kehilangan akibat kelalaian pribadi.',
                ),
                const SizedBox(height: 14),
                // Bullet 2
                _buildBulletPoint(
                  title: 'Penemuan Barang Tertinggal',
                  description:
                      'Jika menemukan barang berharga atau perlengkapan camping yang tertinggal milik camper lain, harap segera serahkan ke Pos Petugas Informasi / Registrasi Utama agar dapat segera diumumkan dan disimpan aman.',
                ),
              ],
            ),
          ),

          // CTA Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _openWhatsApp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.forest,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  'Lapor ke Pos Petugas Registrasi',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint({
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF92400E),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B3B2B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF1B3B2B).withValues(alpha: 0.7),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
