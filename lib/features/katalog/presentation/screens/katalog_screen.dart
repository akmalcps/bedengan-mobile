import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/katalog_models.dart';
import '../widgets/katalog_header.dart';
import '../widgets/warung_item_card.dart';
import '../widgets/rental_item_card.dart';
import '../widgets/photographer_item_card.dart';
import '../widgets/register_vendor_card.dart';
import '../../../../core/utils/app_routes.dart';

class KatalogScreen extends StatefulWidget {
  const KatalogScreen({super.key});

  @override
  State<KatalogScreen> createState() => _KatalogScreenState();
}

class _KatalogScreenState extends State<KatalogScreen> {
  int _selectedFilterIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter lists according to search query
    final query = _searchQuery.toLowerCase().trim();

    final filteredWarungs = dummyWarungs.where((w) {
      if (query.isEmpty) return true;
      return w.name.toLowerCase().contains(query) ||
          w.description.toLowerCase().contains(query) ||
          w.menus.any((m) => m.toLowerCase().contains(query));
    }).toList();

    final filteredRentals = dummyRentals.where((r) {
      if (query.isEmpty) return true;
      return r.name.toLowerCase().contains(query) ||
          r.description.toLowerCase().contains(query) ||
          r.items.any(
            (i) =>
                (i['name'] ?? '').toLowerCase().contains(query) ||
                (i['price'] ?? '').toLowerCase().contains(query),
          );
    }).toList();

    final filteredPhotographers = dummyPhotographers.where((p) {
      if (query.isEmpty) return true;
      return p.username.toLowerCase().contains(query) ||
          p.title.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query);
    }).toList();

    // Determine visibility based on selected filter tab
    // 0: Semua, 1: Warung & Kuliner, 2: Fotografer Wedding, 3: Sewa Alat Camping
    final showWarung =
        (_selectedFilterIndex == 0 || _selectedFilterIndex == 1) &&
        filteredWarungs.isNotEmpty;
    final showRental =
        (_selectedFilterIndex == 0 || _selectedFilterIndex == 3) &&
        filteredRentals.isNotEmpty;
    final showPhotographer =
        (_selectedFilterIndex == 0 || _selectedFilterIndex == 2) &&
        filteredPhotographers.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Header (Brand Bar, Title, Subtitle, Filter Chips, Search Input)
                KatalogHeader(
                  selectedFilterIndex: _selectedFilterIndex,
                  onFilterChanged: (index) {
                    setState(() {
                      _selectedFilterIndex = index;
                    });
                  },
                  searchController: _searchController,
                  onSearchChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                ),

                const SizedBox(height: 24),

                // Section 2 & 3: Warung & Kuliner Lokal
                if (showWarung) ...[
                  _buildSectionTitle(
                    title: 'Warung & Kuliner Lokal',
                    subtitle: 'Warung warga lokal di sekitar area camping',
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredWarungs.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      return WarungItemCard(warung: filteredWarungs[index]);
                    },
                  ),
                  const SizedBox(height: 28),
                ],

                // Section 4 & 5: Sewa Alat Camping & Outdoor
                if (showRental) ...[
                  _buildSectionTitle(
                    title: 'Sewa Alat Camping & Outdoor',
                    subtitle: 'Rental peralatan camping resmi di Bedengan',
                    prefixIcon: Icons.change_history_rounded,
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredRentals.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      return RentalItemCard(rental: filteredRentals[index]);
                    },
                  ),
                  const SizedBox(height: 28),
                ],

                // Section 6 & 7: Fotografer Wedding & Prewedding
                if (showPhotographer) ...[
                  _buildSectionTitle(
                    title: 'Fotografer Wedding & Prewedding',
                    subtitle: 'Nature, love, and timeless memories\nAbadikan momen spesialmu dengan keindahan alam Bedengan sebagai saksinya',
                    prefixIcon: Icons.camera_alt_outlined,
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredPhotographers.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      return PhotographerItemCard(
                        photographer: filteredPhotographers[index],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],

                // Empty Search Fallback
                if (!showWarung && !showRental && !showPhotographer) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 48,
                            color: AppColors.textLight.withValues(alpha: 0.8),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Tidak ada hasil ditemukan',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.forest,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Coba kata kunci pencarian atau filter lain',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Section 8: Register Vendor Card
                const RegisterVendorCard(),

                // Section 9: Sticky Floating Navbar Clearance
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper to build consistent section headers with optional icon
  Widget _buildSectionTitle({
    required String title,
    required String subtitle,
    IconData? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon, size: 20, color: AppColors.primaryDark),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: AppColors.forest,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            height: 1.4,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
