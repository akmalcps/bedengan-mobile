import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';
import '../../theme/app_colors.dart';
import '../../data/mock/warung_mock.dart';
import '../../data/mock/rental_mock.dart';
import '../../data/mock/photographer_mock.dart';
import 'warung_detail_screen.dart';
import 'rental_detail_screen.dart';
import 'photographer_detail_screen.dart';
import '../../widgets/common/app_image.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Warung & Kuliner',
    'Sewa Alat',
    'Fotografer Wedding'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Katalog Kawasan Bedengan'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Cari warung, alat, fotografer...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((category) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: _selectedCategory == category,
                        onSelected: (selected) {
                          if (selected) setState(() => _selectedCategory = category);
                        },
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.white,
                        labelStyle: AppTypography.bodySmall.copyWith(
                          color: _selectedCategory == category ? AppColors.white : AppColors.textSecondary,
                          fontWeight: _selectedCategory == category ? FontWeight.w700 : FontWeight.w400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(
                            color: _selectedCategory == category ? AppColors.primary : AppColors.greyDivider,
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedCategory == 'Semua' || _selectedCategory == 'Warung & Kuliner')
              _buildWarungSection(),
            if (_selectedCategory == 'Semua' || _selectedCategory == 'Sewa Alat')
              _buildRentalSection(),
            if (_selectedCategory == 'Semua' || _selectedCategory == 'Fotografer Wedding')
              _buildPhotographerSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWarungSection() {
    final warungs = WarungMockData.warungs.where((w) => 
      w.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      w.tags.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()))
    ).toList();

    if (warungs.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text('Warung & Kuliner Lokal', style: AppTypography.heading2),
        const SizedBox(height: 4),
        Text('Warung warga lokal di sekitar area camping', style: AppTypography.bodySmall),
        const SizedBox(height: 16),
        ...warungs.map((warung) => _buildCard(
          title: warung.name,
          subtitle: warung.description,
          imageUrl: warung.image,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WarungDetailScreen(warungId: warung.id))),
        )),
      ],
    );
  }

  Widget _buildRentalSection() {
    final rentals = RentalMockData.rentals.where((r) => 
      r.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      r.items.any((i) => i.name.toLowerCase().contains(_searchQuery.toLowerCase()))
    ).toList();

    if (rentals.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text('Sewa Alat Camping & Outdoor', style: AppTypography.heading2),
        const SizedBox(height: 4),
        Text('Rental perlengkapan resmi di Bedengan', style: AppTypography.bodySmall),
        const SizedBox(height: 16),
        ...rentals.map((rental) => _buildCard(
          title: rental.name,
          subtitle: rental.description,
          imageUrl: rental.image,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RentalDetailScreen(rentalId: rental.id))),
        )),
      ],
    );
  }

  Widget _buildPhotographerSection() {
    final photographers = PhotographerMockData.photographers.where((p) => 
      p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      p.instagramUsername.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();

    if (photographers.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text('Fotografer Wedding & Prewedding', style: AppTypography.heading2),
        const SizedBox(height: 4),
        Text('Nature, love, and timeless memories', style: AppTypography.bodySmall),
        const SizedBox(height: 16),
        ...photographers.map((photo) => _buildCard(
          title: photo.name,
          subtitle: photo.description,
          imageUrl: photo.profileImage,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PhotographerDetailScreen(photographerId: photo.id))),
        )),
      ],
    );
  }

  Widget _buildCard({required String title, required String subtitle, required String imageUrl, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            AppImage(
              url: imageUrl,
              width: 80,
              height: 80,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.heading3),
                  const SizedBox(height: 4),
                  Text(subtitle, style: AppTypography.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
