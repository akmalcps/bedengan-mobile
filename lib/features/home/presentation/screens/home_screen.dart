import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/home_header.dart';
import '../widgets/home_hero_buttons.dart';
import '../widgets/home_image_carousel.dart';
import '../widgets/info_cards_section.dart';
import '../widgets/about_bedengan_card.dart';
import '../widgets/visitor_reviews_section.dart';
import '../widgets/location_map_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // 1. Custom App Header (Logo)
              HomeHeader(),

              // 2. Hero Section (Title + 2 Buttons)
              HomeHeroButtons(),

              // 3. Horizontal Image Carousel
              HomeImageCarousel(),

              // 4. Quick Info Cards (Informasi & Ground)
              InfoCardsSection(),

              // 5. Text Section (Tentang Wisata Bedengan)
              AboutBedenganCard(),

              // 6. Visitor Reviews Section
              VisitorReviewsSection(),

              // 7. Location Map Section (Google Maps Launcher)
              LocationMapSection(),

              // Bottom offset for FloatingNavbar
              SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }
}
