import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'routes.dart';

class BedenganApp extends StatelessWidget {
  const BedenganApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bedengan Xplore',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
