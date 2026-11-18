import 'package:flutter/material.dart';

import '../../../../core/constants/api_config.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/katalog_models.dart';
import '../../data/services/katalog_service.dart';
import '../widgets/katalog_header.dart';
import '../widgets/warung_item_card.dart';
import '../widgets/rental_item_card.dart';
import '../widgets/photographer_item_card.dart';
import '../widgets/register_vendor_card.dart';

class KatalogScreen extends StatefulWidget {
  const KatalogScreen({super.key});

  @override
  State<KatalogScreen> createState() => _KatalogScreenState();
}

class _KatalogScreenState extends State<KatalogScreen> {
  final KatalogService _katalogService = KatalogService();
  late Future<List<dynamic>> _catalogsFuture;

  int _selectedFilterIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _catalogsFuture = _katalogService.fetchCatalogs();
  }

  Future<void> _refreshCatalogs() async {
    final future = _katalogService.fetchCatalogs();
    setState(() {
      _catalogsFuture = future;
    });
    await future;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Helper untuk mengekstrak list string dari field tags / tags_raw JSON
  List<String> _parseTagsList(dynamic rawTags) {
    if (rawTags is List) {
      return rawTags
          .map((e) => e.toString().trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    if (rawTags is String && rawTags.trim().isNotEmpty) {
      return rawTags
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return [];
  }

  /// Helper untuk menyusun tautan WhatsApp dari nomor telepon
  String _buildWaLink(String rawPhone, String name, String prefixMsg) {
    String digits = rawPhone.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.startsWith('0')) {
      digits = '62${digits.substring(1)}';
    } else if (digits.isNotEmpty && !digits.startsWith('62')) {
      digits = '62$digits';
    }
    if (digits.isEmpty) digits = '6281234567890';
    final encodedText = Uri.encodeComponent('Halo $name, $prefixMsg');
    return 'https://wa.me/$digits?text=$encodedText';
  }

  /// Helper untuk memetakan JSON item ke WarungModel
  WarungModel _mapToWarung(Map<String, dynamic> item) {
    final name = (item['name'] ?? 'Warung Bedengan').toString().trim();
    final rawTime = (item['operating_hours'] ?? '').toString().trim();
    final time = rawTime.isNotEmpty ? rawTime : '07.00 - 21.00';
    final description = (item['description'] ?? '').toString().trim();
    final menus = _parseTagsList(item['tags'] ?? item['tags_raw']);
    final phone = (item['contact_phone'] ?? '').toString().trim();
    final waLink = _buildWaLink(
      phone,
      name,
      'saya ingin pesan makanan/minuman',
    );

    return WarungModel(
      name: name,
      time: time,
      description: description,
      menus: menus,
      waLink: waLink,
    );
  }

  /// Helper untuk memetakan JSON item ke RentalModel
  RentalModel _mapToRental(Map<String, dynamic> item) {
    final name = (item['name'] ?? 'Rental Camping').toString().trim();
    final description = (item['description'] ?? '').toString().trim();
    final tags = _parseTagsList(item['tags'] ?? item['tags_raw']);
    final rawPrice = (item['price_text'] ?? '').toString().trim();
    final priceText = rawPrice.isNotEmpty ? rawPrice : 'Tersedia';

    final List<Map<String, String>> rentalItems = tags.map((tag) {
      return {
        'name': tag,
        'price': priceText,
      };
    }).toList();

    final phone = (item['contact_phone'] ?? '').toString().trim();
    final waLink = _buildWaLink(phone, name, 'saya ingin sewa alat camping');

    final rawBannerUrl =
        (item['banner_url'] ?? item['image_url'] ?? '').toString().trim();
    final bannerUrl = ApiConfig.resolveImageUrl(rawBannerUrl);

    return RentalModel(
      name: name,
      description: description,
      items: rentalItems,
      waLink: waLink,
      bannerUrl: bannerUrl,
    );
  }

  /// Helper untuk memetakan JSON item ke PhotographerModel
  PhotographerModel _mapToPhotographer(Map<String, dynamic> item) {
    final name = (item['name'] ?? 'Fotografer Bedengan').toString().trim();
    String rawHandle = (item['social_handle'] ?? '').toString().trim();
    if (rawHandle.isEmpty) {
      final slug = name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
      rawHandle = '@${slug.isNotEmpty ? slug : 'bedengan.photo'}';
    } else if (!rawHandle.startsWith('@')) {
      rawHandle = '@$rawHandle';
    }

    final cleanHandle = rawHandle.replaceFirst(RegExp(r'^@'), '');
    final rawLocation = (item['location_note'] ?? '').toString().trim();
    final rawPrice = (item['price_text'] ?? '').toString().trim();
    final subtitlePart = rawLocation.isNotEmpty
        ? rawLocation
        : (rawPrice.isNotEmpty ? rawPrice : 'Only-MLG');
    final title = '$name | $subtitlePart';

    final nameParts = name
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    String initials = 'PH';
    if (nameParts.length >= 2) {
      initials = '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else if (nameParts.length == 1 && nameParts[0].length >= 2) {
      initials = nameParts[0].substring(0, 2).toUpperCase();
    }

    final resolvedUrl = ApiConfig.resolveImageUrl(
      item['image_url']?.toString() ?? '',
    );
    final List<String> defaultSamples = [
      'https://images.unsplash.com/photo-1519741497674-611481863552?q=80&w=600&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1511285560929-80b456fea0bc?q=80&w=600&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1465495976277-4387d4b0b4c6?q=80&w=600&auto=format&fit=crop',
    ];
    final List<String> imageUrls = resolvedUrl.isNotEmpty
        ? [resolvedUrl, defaultSamples[1], defaultSamples[2]]
        : defaultSamples;

    final description = (item['description'] ?? '').toString().trim();
    final igLink = 'https://instagram.com/$cleanHandle';

    return PhotographerModel(
      username: rawHandle,
      title: title,
      avatarInitials: initials,
      imageUrls: imageUrls,
      description: description,
      igLink: igLink,
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchQuery.toLowerCase().trim();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: _refreshCatalogs,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
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
                    showBackButton: true,
                    onBackPressed: () => Navigator.maybePop(context),
                  ),

                  const SizedBox(height: 24),

                  // Data Katalog dari API Backend
                  FutureBuilder<List<dynamic>>(
                    future: _catalogsFuture,
                    builder: (context, snapshot) {
                      // 1. State Loading
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 64.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }

                      // 2. State Error
                      if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.cloud_off_rounded,
                                  size: 48,
                                  color: AppColors.textLight.withValues(
                                    alpha: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Gagal memuat data katalog',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.forest,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  snapshot.error
                                      .toString()
                                      .replaceAll('Exception: ', ''),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: _refreshCatalogs,
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                    size: 18,
                                  ),
                                  label: const Text('Coba Lagi'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: AppColors.forest,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const RegisterVendorCard(),
                                const SizedBox(height: 120),
                              ],
                            ),
                          ),
                        );
                      }

                      // 3. State Data (Map JSON -> Models)
                      final rawList = snapshot.data ?? [];
                      final List<WarungModel> warungs = [];
                      final List<RentalModel> rentals = [];
                      final List<PhotographerModel> photographers = [];

                      for (final rawItem in rawList) {
                        if (rawItem is! Map<String, dynamic>) continue;

                        // Filter defensif: pastikan hanya menampilkan status approved
                        final status = (rawItem['status'] ?? 'approved')
                            .toString()
                            .toLowerCase();
                        if (status != 'approved') continue;

                        final category = (rawItem['category'] ?? '')
                            .toString()
                            .toLowerCase();
                        if (category == 'warung') {
                          warungs.add(_mapToWarung(rawItem));
                        } else if (category == 'rental') {
                          rentals.add(_mapToRental(rawItem));
                        } else if (category == 'photographer') {
                          photographers.add(_mapToPhotographer(rawItem));
                        }
                      }

                      // Filter berdasarkan search query
                      final filteredWarungs = warungs.where((w) {
                        if (query.isEmpty) return true;
                        return w.name.toLowerCase().contains(query) ||
                            w.description.toLowerCase().contains(query) ||
                            w.menus.any((m) => m.toLowerCase().contains(query));
                      }).toList();

                      final filteredRentals = rentals.where((r) {
                        if (query.isEmpty) return true;
                        return r.name.toLowerCase().contains(query) ||
                            r.description.toLowerCase().contains(query) ||
                            r.items.any(
                              (i) =>
                                  (i['name'] ?? '')
                                      .toLowerCase()
                                      .contains(query) ||
                                  (i['price'] ?? '')
                                      .toLowerCase()
                                      .contains(query),
                            );
                      }).toList();

                      final filteredPhotographers = photographers.where((p) {
                        if (query.isEmpty) return true;
                        return p.username.toLowerCase().contains(query) ||
                            p.title.toLowerCase().contains(query) ||
                            p.description.toLowerCase().contains(query);
                      }).toList();

                      // Determine visibility based on selected filter tab
                      // 0: Semua, 1: Warung & Kuliner, 2: Fotografer Wedding, 3: Sewa Alat Camping
                      final showWarung =
                          (_selectedFilterIndex == 0 ||
                              _selectedFilterIndex == 1) &&
                          filteredWarungs.isNotEmpty;
                      final showRental =
                          (_selectedFilterIndex == 0 ||
                              _selectedFilterIndex == 3) &&
                          filteredRentals.isNotEmpty;
                      final showPhotographer =
                          (_selectedFilterIndex == 0 ||
                              _selectedFilterIndex == 2) &&
                          filteredPhotographers.isNotEmpty;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section 2 & 3: Warung & Kuliner Lokal
                          if (showWarung) ...[
                            _buildSectionTitle(
                              title: 'Warung & Kuliner Lokal',
                              subtitle:
                                  'Warung warga lokal di sekitar area camping',
                            ),
                            const SizedBox(height: 12),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredWarungs.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 14),
                              itemBuilder: (context, index) {
                                return WarungItemCard(
                                  warung: filteredWarungs[index],
                                );
                              },
                            ),
                            const SizedBox(height: 28),
                          ],

                          // Section 4 & 5: Sewa Alat Camping & Outdoor
                          if (showRental) ...[
                            _buildSectionTitle(
                              title: 'Sewa Alat Camping & Outdoor',
                              subtitle:
                                  'Rental peralatan camping resmi di Bedengan',
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
                                return RentalItemCard(
                                  rental: filteredRentals[index],
                                );
                              },
                            ),
                            const SizedBox(height: 28),
                          ],

                          // Section 6 & 7: Fotografer Wedding & Prewedding
                          if (showPhotographer) ...[
                            _buildSectionTitle(
                              title: 'Fotografer Wedding & Prewedding',
                              subtitle:
                                  'Nature, love, and timeless memories\nAbadikan momen spesialmu dengan keindahan alam Bedengan sebagai saksinya',
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
                          if (!showWarung &&
                              !showRental &&
                              !showPhotographer) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 40.0,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.search_off_rounded,
                                      size: 48,
                                      color: AppColors.textLight.withValues(
                                        alpha: 0.8,
                                      ),
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
                      );
                    },
                  ),
                ],
              ),
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
