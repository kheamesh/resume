import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'screens/home/home_screen.dart';
import 'controllers/pdf_controller.dart';
import 'controllers/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  Get.put(PdfController());
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      themeMode: themeController.themeMode,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      home: const HomeScreen(),
    ));
  }
}
