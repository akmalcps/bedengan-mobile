import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared_widgets/floating_navbar.dart';
import '../../../home/presentation/widgets/home_header.dart';
import '../../data/models/rule_model.dart';
import '../widgets/warning_card.dart';
import '../widgets/rule_item_card.dart';
import '../widgets/evacuation_map_card.dart';
import '../widgets/contact_info_cards.dart';

class PanduanScreen extends StatelessWidget {
  const PanduanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Layer 1: Scrollable Content ──
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Custom App Bar (Logo + Back Button)
                SafeArea(
                  bottom: false,
                  child: HomeHeader(
                    showBackButton: true,
                    onBackPressed: () => Navigator.maybePop(context),
                  ),
                ),

                // Section 2: Header
                _buildHeader(),

                const SizedBox(height: 20),

                // Section 3: Warning Card
                const WarningCard(),

                const SizedBox(height: 28),

                // Section 4: Section Title — Tata Tertib Pengunjung
                _buildSectionTitle(),

                const SizedBox(height: 12),

                // Section 5: Rules List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dummyRules.length,
                  itemBuilder: (context, index) {
                    return RuleItemCard(rule: dummyRules[index]);
                  },
                ),

                const SizedBox(height: 24),

                // Section 6: Evacuation Map
                const EvacuationMapCard(),

                const SizedBox(height: 20),

                // Section 7: Contact Info Cards
                const ContactInfoCards(),

                const SizedBox(height: 32),

                // Section 8: Footer
                _buildFooter(),

                // Section 9: Bottom Padding for Floating Navbar
                const SizedBox(height: 120),
              ],
            ),
          ),

          // ── Layer 2: Floating Navbar ──
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: FloatingNavbar(
              currentIndex: -1, // No tab active on sub-screen
              onItemSelected: (index) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboard',
                  (route) => false,
                  arguments: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────
  // Header Section
  // ───────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chip / Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.sageLight,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Text(
              'Informasi & Keselamatan Kawasan',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.forest,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Title
          const Text(
            'Panduan & Tata Tertib\nPengunjung',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.forest,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),

          // Description
          Text(
            'Demi keamanan, kenyamanan bersama, dan kelestarian ekosistem alam bumi perkemahan Bedengan Malang.',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────
  // Section Title: Tata Tertib + Badge
  // ───────────────────────────────────────────────────────
  Widget _buildSectionTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Tata Tertib Pengunjung',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.forest,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFDCEAD7),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Text(
              'Wajib Dipatuhi',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.forest,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────
  // Footer: SALAM LESTARI
  // ───────────────────────────────────────────────────────
  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          const Text(
            'SALAM LESTARI',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.forest,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              '"Lestari Alamku, Nyaman Berkemah di Bedengan Xplore."',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
