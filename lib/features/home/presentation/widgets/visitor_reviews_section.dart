import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class VisitorReviewsSection extends StatefulWidget {
  const VisitorReviewsSection({super.key});

  @override
  State<VisitorReviewsSection> createState() => _VisitorReviewsSectionState();
}

class _VisitorReviewsSectionState extends State<VisitorReviewsSection> {
  final List<Map<String, dynamic>> _reviews = [
    {
      'initials': 'RM',
      'avatarBg': Color(0xFFC7E8D2),
      'name': 'Rian & Maya',
      'role': 'Keluarga • Surabaya',
      'rating': 5,
      'quote': '“Suasana aliran sungainya sangat jernih dan ramah anak. Udaranya sejuk khas pinus”',
      'zone': 'Zona B (Tepi Sungai)',
      'time': '2 hari lalu',
    },
    {
      'initials': 'DP',
      'avatarBg': Color(0xFFE2F0CB),
      'name': 'Dimas P.',
      'role': 'Solo Camper • Malang',
      'rating': 5,
      'quote': '“Spot Ground F tenang banget buat yang suka ketenangan. Tidur super nyenyak tiap akhir pekan.”',
      'zone': 'Zona F (Hutan Pinus)',
      'time': '5 hari lalu',
    },
    {
      'initials': 'AS',
      'avatarBg': Color(0xFFD6EAE2),
      'name': 'Anisa S.',
      'role': 'Komunitas • Sidoarjo',
      'rating': 5,
      'quote': '“Fasilitas toilet bersih, sumber air melimpah. Sangat rekomendasi buat acara camping bareng tim.”',
      'zone': 'Zona A (Dekat Pos)',
      'time': '1 minggu lalu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pendapat dari Pengunjung',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.forest,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (_) => const Icon(
                        Icons.star_rounded,
                        color: AppColors.star,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '4.9/5',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.forest,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '(1.200+ camper)',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 13,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Horizontal Swipeable ListView.builder
        SizedBox(
          height: 185,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _reviews.length,
            itemBuilder: (context, index) {
              final review = _reviews[index];
              return Container(
                width: 290,
                margin: const EdgeInsets.only(right: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: AppColors.sageBorder.withValues(alpha: 0.6),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Header: Avatar, Name, Rating
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: review['avatarBg'] as Color,
                          child: Text(
                            review['initials'] as String,
                            style: const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.forest,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review['name'] as String,
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.forest,
                                ),
                              ),
                              Text(
                                review['role'] as String,
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: List.generate(
                            review['rating'] as int,
                            (_) => const Icon(
                              Icons.star_rounded,
                              color: AppColors.star,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Quote Body
                    Text(
                      review['quote'] as String,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                        color: AppColors.forestMuted,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Footer: Zone tag & time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              review['zone'] as String,
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          review['time'] as String,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 11,
                            color: AppColors.textLight,
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

        const SizedBox(height: 12),

        // Indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: AppColors.sageBorder,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: AppColors.sageBorder,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
