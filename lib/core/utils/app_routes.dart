import 'package:flutter/material.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/ground_camping/presentation/screens/ground_camping_screen.dart';
import '../../features/panduan/presentation/screens/panduan_screen.dart';
import '../../features/katalog/presentation/screens/katalog_screen.dart';
import '../../features/katalog/presentation/screens/register_vendor_screen.dart';
import '../../shared_widgets/main_dashboard.dart';

class AppRoutes {
  static const String splash = '/';
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String groundCamping = '/ground-camping';
  static const String panduan = '/panduan';
  static const String katalog = '/katalog';
  static const String registerVendor = '/register-vendor';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case dashboard:
        final initialIndex = settings.arguments as int? ?? 0;
        return MaterialPageRoute(
          builder: (_) => MainDashboard(initialIndex: initialIndex),
        );
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case groundCamping:
        return MaterialPageRoute(builder: (_) => const GroundCampingScreen());
      case panduan:
        return MaterialPageRoute(builder: (_) => const PanduanScreen());
      case katalog:
        return MaterialPageRoute(builder: (_) => const KatalogScreen());
      case registerVendor:
        return MaterialPageRoute(builder: (_) => const RegisterVendorScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
