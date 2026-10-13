import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';

class LocationMapSection extends StatelessWidget {
  const LocationMapSection({super.key});

  static const double latitude = -7.9572;
  static const double longitude = 112.5298;

  Future<void> _openGoogleMaps(BuildContext context) async {
    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    try {
      final launched = await launchUrl(
        googleMapsUrl,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak dapat membuka aplikasi Google Maps.'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          const Text(
            'LOKASI & NAVIGASI',
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
            'Peta Satelit Kawasan',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.forest,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Temukan lokasi tepat tempat kemping impianmu di Bedengan, lengkap dengan akses jalan dan pemandangan alam sekitar, melalui tampilan satelit.',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Main Map Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header: Pin & Coordinates
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Dau, Selorejo, Malang',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.forest,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Jawa Timur • -7.9572, 112.5298',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 11,
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Stylized Visual Map Preview
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    height: 190,
                    width: double.infinity,
                    color: const Color(0xFFD8EFE3),
                    child: Stack(
                      children: [
                        // Custom Painted Terrain & Waterways
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _BedenganMapPainter(),
                          ),
                        ),

                        // Landmark: Kopikali
                        Positioned(
                          top: 42,
                          left: 140,
                          child: _buildMapBadge(
                            title: 'Kopikali',
                            icon: Icons.local_cafe_rounded,
                            iconColor: const Color(0xFFD97706),
                          ),
                        ),

                        // Landmark: Puncak Bukit
                        Positioned(
                          top: 52,
                          left: 20,
                          child: _buildMapBadge(
                            title: 'Puncak Bukit Datar',
                            icon: Icons.landscape_rounded,
                            iconColor: AppColors.forest,
                          ),
                        ),

                        // Landmark: Musholla Bedengan 2
                        Positioned(
                          bottom: 24,
                          left: 50,
                          child: _buildMapBadge(
                            title: 'Musholla Bedengan 2',
                            icon: Icons.mosque_rounded,
                            iconColor: const Color(0xFF4B5563),
                          ),
                        ),

                        // Main Landmark: Bedengan Camping Ground Pin
                        Positioned(
                          top: 68,
                          right: 48,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                color: Colors.red,
                                size: 28,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'Bedengan\nCamping Ground',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Google Maps Watermark Badge
                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Google Maps',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Alamat Section Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Alamat',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.forest,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Jl. Raya Selorejo, Dusun Selokerto, Dau, Kabupaten Malang',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Aksesibilitas Kendaraan Section Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Aksesibilitas Kendaraan',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.forest,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '± 45 menit dari Pusat Kota Malang (Akses Mobil & Motor Aman)',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Button: Buka di Google Maps
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.forest,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () => _openGoogleMaps(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.navigation_rounded,
                          color: AppColors.forest,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Buka di Google Maps',
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
          ),
        ],
      ),
    );
  }

  Widget _buildMapBadge({
    required String title,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: iconColor),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: AppColors.forest,
            ),
          ),
        ],
      ),
    );
  }
}

class _BedenganMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Water stream lines
    final waterPaint = Paint()
      ..color = const Color(0xFF81D4FA)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke;

    final roadPaint = Paint()
      ..color = const Color(0xFFC8E6C9)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // Road path
    final roadPath = Path()
      ..moveTo(0, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.58, size.width, size.height * 0.68);
    canvas.drawPath(roadPath, roadPaint);

    // River main stream
    final riverPath = Path()
      ..moveTo(size.width * 0.35, 0)
      ..cubicTo(
        size.width * 0.4,
        size.height * 0.35,
        size.width * 0.55,
        size.height * 0.45,
        size.width * 0.7,
        size.height * 0.5,
      )
      ..cubicTo(
        size.width * 0.8,
        size.height * 0.55,
        size.width * 0.85,
        size.height * 0.7,
        size.width,
        size.height * 0.75,
      );
    canvas.drawPath(riverPath, waterPaint);

    // River branch
    final branchPath = Path()
      ..moveTo(size.width * 0.65, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.55, size.height * 0.68, size.width * 0.45, size.height);
    canvas.drawPath(branchPath, waterPaint);

    // Top horizontal stream
    final topStream = Path()
      ..moveTo(0, size.height * 0.28)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.26, size.width * 0.6, size.height * 0.24)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.22, size.width, size.height * 0.26);
    canvas.drawPath(topStream, waterPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
