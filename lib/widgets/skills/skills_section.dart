// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';
import '../../controllers/background_controller.dart';
import '../../models/skill.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);
    final isMobile = ResponsiveLayout.isMobile(context);
    final controller = Get.find<BackgroundController>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 100),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: _buildHeader(context),
          ),
          const SizedBox(height: 80),

          if (isMobile)
            _buildMobileLayout(context)
          else
            Stack(
              alignment: Alignment.center,
              children: [
                // Decorative Rings Background
                // _buildDecorativeRings(controller.animationController),
                _buildDesktopLayout(context, controller.animationController),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    Animation<double> animation,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1500),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: PortfolioData.skillCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: 4.2,
          ),
          itemBuilder: (context, index) {
            final category = PortfolioData.skillCategories[index];
            final isLeft = index % 2 == 0;
            return isLeft
                ? FadeInLeft(
                    duration: const Duration(milliseconds: 800),
                    delay: Duration(milliseconds: index * 100),
                    child: _buildSkillCategory(context, category),
                  )
                : FadeInRight(
                    duration: const Duration(milliseconds: 800),
                    delay: Duration(milliseconds: index * 100),
                    child: _buildSkillCategory(context, category),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, SkillCategory category) {
    return _buildSkillCategoryCard(context, category);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: PortfolioData.skillCategories.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: Duration(milliseconds: index * 100),
          child: _buildSkillCategoryCard(
            context,
            PortfolioData.skillCategories[index],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    const app_color = AppColors.gold;
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.skillsAndTech,
          style: TextStyle(
            color: app_color,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 10),
        Container(width: 50, height: 2, color: app_color),
      ],
    );
  }

  Widget _buildSkillCategoryCard(BuildContext context, SkillCategory category) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const app_color = AppColors.gold;

    return GetBuilder<SkillHoverController>(
      init: SkillHoverController(),
      tag: category.title,
      builder: (controller) {
        return MouseRegion(
          onEnter: (_) => controller.setHovered(true),
          onExit: (_) => controller.setHovered(false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: ResponsiveLayout.isMobile(context) ? double.infinity : 500,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF050505) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: controller.isHovered
                    ? app_color
                    : app_color.withValues(alpha: 0.15),
                width: controller.isHovered ? 1.5 : 0.5,
              ),
              boxShadow: [
                if (controller.isHovered)
                  BoxShadow(
                    color: app_color.withValues(alpha: 0.2),
                    blurRadius: 30,
                    spreadRadius: -5,
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: controller.isHovered
                            ? app_color.withValues(alpha: 0.2)
                            : app_color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(category.title),
                        color: app_color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      category.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: category.skills
                      .map(
                        (skill) => _buildSkillChip(
                          context,
                          skill,
                          controller.isHovered,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String title) {
    if (title.contains("Mobile")) return AppIcons.mobileApp;
    if (title.contains("State")) return AppIcons.getx;
    if (title.contains("Backend")) return AppIcons.api;
    if (title.contains("Tools")) return AppIcons.uiDesign;
    return AppIcons.code;
  }

  Widget _buildSkillChip(
    BuildContext context,
    Skill skill,
    bool parentHovered,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app_icon = skill.icon;
    const app_color = AppColors.gold;
    final brandColor = _getBrandColor(skill.name);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? (parentHovered
                  ? const Color(0xFF151515)
                  : const Color(0xFF101010))
            : (parentHovered
                  ? const Color(0xFFF1F5F9)
                  : const Color(0xFFF8FAFC)),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: parentHovered
              ? app_color.withValues(alpha: 0.3)
              : app_color.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (app_icon != null) Icon(app_icon, size: 18, color: brandColor),
          const SizedBox(width: 10),
          Text(
            skill.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).textTheme.bodyLarge?.color?.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

Color _getBrandColor(String name) {
  name = name.toLowerCase();
  if (name.contains("flutter")) return Colors.blue;
  if (name.contains("dart")) return Colors.blueAccent;
  if (name.contains("android")) return Colors.green;
  if (name.contains("ios")) return Colors.grey;
  if (name.contains("getx")) return Colors.deepPurpleAccent;
  if (name.contains("provider")) return Colors.blue;
  if (name.contains("riverpod")) return Colors.lightBlue;
  if (name.contains("firebase")) return Colors.orangeAccent;
  if (name.contains("api") || name.contains("dio")) return Colors.orange;
  if (name.contains("auth")) return Colors.redAccent;
  if (name.contains("git")) return const Color(0xFFF05032);
  if (name.contains("figma")) return Colors.purple;
  if (name.contains("postman")) return Colors.orange;
  return AppColors.gold;
}

class SkillHoverController extends GetxController {
  bool isHovered = false;

  void setHovered(bool val) {
    isHovered = val;
    update();
  }
}
