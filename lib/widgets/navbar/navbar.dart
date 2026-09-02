import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/constants/app_strings.dart';
import '../../data/portfolio_data.dart';
import '../../controllers/theme_controller.dart';

class Navbar extends StatelessWidget {
  final Function(int) onNavTap;
  const Navbar({super.key, required this.onNavTap});

  final List<String> _navItems = const [
    AppStrings.navHome,
    AppStrings.navAbout,
    AppStrings.navExperience,
    AppStrings.navProjects,
    AppStrings.navSkills,
    AppStrings.navServices,
    AppStrings.navContact,
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerTheme.color ?? Colors.grey.withValues(alpha: 0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLogo(),
                if (ResponsiveLayout.isDesktop(context))
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: _buildDesktopNav(context),
                          ),
                        ),
                        const SizedBox(width: 20),
                        _buildThemeToggle(),
                      ],
                    ),
                  )
                else
                  Row(
                    children: [
                      _buildThemeToggle(),
                      _buildMobileNavTrigger(context),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    final themeController = Get.find<ThemeController>();
    return Obx(() => IconButton(
          icon: Icon(
            themeController.isDarkMode.value ? AppIcons.themeLight : AppIcons.themeDark,
            color: AppColors.gold,
          ),
          onPressed: () => themeController.toggleTheme(),
        ));
  }

  Widget _buildLogo() {
    return Text(
      PortfolioData.name.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 20,
        letterSpacing: 2,
        color: AppColors.gold,
      ),
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    return Row(
      children: List.generate(_navItems.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextButton(
            onPressed: () => onNavTap(index),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            child: Text(
              _navItems[index],
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMobileNavTrigger(BuildContext context) {
    return IconButton(
      icon: const Icon(AppIcons.menu, color: AppColors.gold),
      onPressed: () => _showMobileMenu(context),
    );
  }

  void _showMobileMenu(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_navItems.length, (index) {
            return ListTile(
              title: Text(
                _navItems[index],
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              onTap: () {
                Get.back();
                onNavTap(index);
              },
            );
          }),
        ),
      ),
    );
  }
}
