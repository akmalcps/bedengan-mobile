import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class KatalogHeader extends StatelessWidget {
  final int selectedFilterIndex;
  final ValueChanged<int> onFilterChanged;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;

  const KatalogHeader({
    super.key,
    required this.selectedFilterIndex,
    required this.onFilterChanged,
    this.searchController,
    this.onSearchChanged,
  });

  static const List<String> filters = [
    'Semua',
    'Warung & Kuliner',
    'Fotografer Wedding',
    'Sewa Alat Camping',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Brand Bar (matches screenshot)
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (Navigator.canPop(context))
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                const SizedBox(width: 40),

              // Centered Brand Logo
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 30,
                    height: 24,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 1,
                          right: 6,
                          child: Container(
                            width: 6,
                            height: 6,
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
                              size: 20,
                              color: AppColors.forest,
                            ),
                            Icon(
                              Icons.park_rounded,
                              size: 14,
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
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: AppColors.forest,
                    ),
                  ),
                  const Text(
                    'XPLORE',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 40),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Main Title
        const Text(
          'Katalog Kawasan Bedengan',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.forest,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 8),

        // Subtitle
        const Text(
          'Direktori warung lokal, kuliner seputar perkemahan, dan kontak jasa fotografer prewedding & wedding di alam Bedengan.',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: AppColors.textSecondary,
          ),
        ),

        const SizedBox(height: 18),

        // Horizontally Scrollable Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(filters.length, (index) {
              final isSelected = selectedFilterIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () => onFilterChanged(index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.sageLight.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.sageBorder,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      filters[index],
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 12.5,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w600,
                        color: isSelected
                            ? AppColors.forest
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 16),

        // Search Bar Input Field
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.sageBorder.withValues(alpha: 0.8),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13.5,
              color: AppColors.forest,
            ),
            decoration: InputDecoration(
              hintText: 'Cari warung, mie rebus, fotografer...',
              hintStyle: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.textLight,
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 14, right: 8),
                child: Icon(
                  Icons.search_rounded,
                  color: AppColors.textLight,
                  size: 20,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 42,
                minHeight: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
