import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_routes.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BedenganApp());
}

class BedenganApp extends StatelessWidget {
  const BedenganApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bedengan Xplore',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
