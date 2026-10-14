import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared_widgets/floating_navbar.dart';
import '../../data/models/ground_model.dart';
import '../widgets/overall_map_card.dart';
import '../widgets/ground_item_card.dart';
import '../widgets/etiquette_card.dart';

class GroundCampingScreen extends StatefulWidget {
  const GroundCampingScreen({super.key});

  @override
  State<GroundCampingScreen> createState() => _GroundCampingScreenState();
}

class _GroundCampingScreenState extends State<GroundCampingScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Layer 1 (Background): Scrollable Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Custom App Bar / Header
                    _buildCustomAppBar(context),

                    const SizedBox(height: 16),

                    // Section 2: Location Chip + Title + Subtitle
                    _buildHeaderSection(),

                    const SizedBox(height: 20),

                    // Section 3: Overall Map Card
                    const OverallMapCard(),

                    const SizedBox(height: 24),

                    // Section 4: Title "Daftar Ground (A – M)"
                    const Text(
                      'Daftar Ground (A – M)',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.forest,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Section 5: Dynamic List of Ground Cards
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dummyGrounds.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return GroundItemCard(ground: dummyGrounds[index]);
                      },
                    ),

                    const SizedBox(height: 20),

                    // Section 6: Etiquette Card
                    const EtiquetteCard(),

                    // Section 7: Bottom Clearance for Sticky Floating Navbar
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),

          // Layer 2 (Foreground): Sticky Floating Navbar at the Bottom
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: true,
              child: FloatingNavbar(
                currentIndex: _currentNavIndex,
                onItemSelected: (index) {
                  setState(() {
                    _currentNavIndex = index;
                  });
                  if (index == 0) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Custom App Bar with Back Button and Centered BEDENGAN XPLORE Logo
  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.chevron_left_rounded,
                size: 28,
                color: AppColors.forest,
              ),
            ),
          ),

          // Centered Logo & Brand Name
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 32,
                height: 24,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 1,
                      right: 7,
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
                          size: 22,
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

          // Symmetrical spacer for balance
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  /// Header Section with Location Chip, Main Title, and Subtitle
  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location Chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.sageLight.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.sageBorder,
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.location_on_rounded,
                size: 14,
                color: AppColors.primaryDark,
              ),
              SizedBox(width: 5),
              Text(
                '13 Zona Berkemah Terpadu',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.forest,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Main Title
        const Text(
          'Ground Camping\nBedengan',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 27,
            fontWeight: FontWeight.w800,
            color: AppColors.forest,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 10),

        // Subtitle Description with Bold Highlights
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: AppColors.textSecondary,
            ),
            children: [
              TextSpan(text: 'Pilih zona berkemah ideal Anda dari '),
              TextSpan(
                text: 'Ground A hingga Ground M',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.forest,
                ),
              ),
              TextSpan(
                text:
                    '. Temukan area tepi sungai jernih, keteduhan pinus lebat, hingga akses dekat pos utama.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
