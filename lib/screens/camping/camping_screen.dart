import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';
import '../../theme/app_colors.dart';
import '../../data/mock/camping_area_mock.dart';
import '../../widgets/common/app_image.dart';

class CampingScreen extends StatelessWidget {
  const CampingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final areas = CampingAreaMockData.areas;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Jelajahi Ground Camping'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: areas.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final area = areas[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CampingDetailScreen(areaId: area.id),
                ),
              );
            },
            child: Container(
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
                children: [
                  AppImage(
                    url: area.image,
                    height: 150,
                    width: double.infinity,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(area.number, style: AppTypography.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text(area.name, style: AppTypography.heading3),
                        const SizedBox(height: 8),
                        Text(
                          area.description,
                          style: AppTypography.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: area.status == 'Tersedia' ? AppColors.primary.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                area.status,
                                style: AppTypography.bodySmall.copyWith(
                                  color: area.status == 'Tersedia' ? AppColors.primary : Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CampingDetailScreen extends StatelessWidget {
  final String areaId;

  const CampingDetailScreen({super.key, required this.areaId});

  @override
  Widget build(BuildContext context) {
    final area = CampingAreaMockData.areas.firstWhere((e) => e.id == areaId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: AppImage(url: area.image),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(area.number, style: AppTypography.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(area.name, style: AppTypography.display),
                  const SizedBox(height: 24),
                  Text('Deskripsi', style: AppTypography.heading3),
                  const SizedBox(height: 8),
                  Text(area.description, style: AppTypography.bodyMedium),
                  const SizedBox(height: 24),
                  Text('Fasilitas', style: AppTypography.heading3),
                  const SizedBox(height: 8),
                  ...area.facilities.map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppColors.primary, size: 16),
                        const SizedBox(width: 8),
                        Text(f, style: AppTypography.bodyMedium),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
