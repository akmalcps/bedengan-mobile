import 'package:flutter/material.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/katalog/presentation/screens/katalog_screen.dart';
import 'floating_navbar.dart';

class MainDashboard extends StatefulWidget {
  final int initialIndex;

  const MainDashboard({super.key, this.initialIndex = 0});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Dynamic Screen Background
          IndexedStack(
            index: _currentIndex,
            children: const [
              HomeScreen(),
              KatalogScreen(),
            ],
          ),

          // Floating Navigation Bar positioned at bottom center
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: SafeArea(
              child: FloatingNavbar(
                currentIndex: _currentIndex,
                onItemSelected: _onTabSelected,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
