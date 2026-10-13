import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class GroundCampingScreen extends StatelessWidget {
  const GroundCampingScreen({super.key});

  final List<Map<String, dynamic>> _zones = const [
    {
      'code': 'Zona A',
      'title': 'Area Pinus Utama & Pos 1',
      'desc': 'Dekat dengan pos registrasi, toilet sentral, dan warung. Cocok untuk pemula dan keluarga.',
      'capacity': '30 Tenda',
      'highlight': 'Akses Mudah & Dekat Parkir',
      'icon': Icons.forest_rounded,
    },
    {
      'code': 'Zona B',
      'title': 'Tepi Aliran Sungai (Riverbank)',
      'desc': 'Spot favorit paling populer langsung berhadapan dengan aliran air jernih bebatuan.',
      'capacity': '20 Tenda',
      'highlight': 'Suasana Gemericik Air',
      'icon': Icons.water_rounded,
    },
    {
      'code': 'Zona C',
      'title': 'Lembah Sungai Bawah',
      'desc': 'Area teduh di bawah rindang pohon pinus besar dengan akses langsung bermain air.',
      'capacity': '25 Tenda',
      'highlight': 'Teduh & Alami',
      'icon': Icons.terrain_rounded,
    },
    {
      'code': 'Zona D',
      'title': 'Plaza Pinus Atas',
      'desc': 'Tanah lapang luas, sangat ideal untuk kegiatan gathering komunitas atau outbound grup.',
      'capacity': '40 Tenda',
      'highlight': 'Luas & Rata',
      'icon': Icons.groups_rounded,
    },
    {
      'code': 'Zona E',
      'title': 'Bukit Pinus Barat',
      'desc': 'Pemandangan perbukitan sejuk dengan angin sepoi-sepoi dan panorama matahari terbit.',
      'capacity': '15 Tenda',
      'highlight': 'Pemandangan Sunset/Sunrise',
      'icon': Icons.wb_twilight_rounded,
    },
    {
      'code': 'Zona F',
      'title': 'Deep Forest Sanctuary',
      'desc': 'Zona paling tenang dan privat untuk solo camper atau penikmat suasana hening alam liar.',
      'capacity': '12 Tenda',
      'highlight': 'Hening & Privat',
      'icon': Icons.nature_people_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Jelajahi Ground Camping',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.forest,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: _zones.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final zone = _zones[index];
            return Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          zone['code'] as String,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.forest,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.sageLight,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          zone['capacity'] as String,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.forest,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(zone['icon'] as IconData, color: AppColors.forestMuted, size: 22),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    zone['title'] as String,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.forest,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    zone['desc'] as String,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 13,
                      height: 1.4,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        zone['highlight'] as String,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.forest,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
