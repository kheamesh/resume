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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWebWithTitle(
              context,
              PortfolioData.skillCategories[0],
              animation,
              index: 0,
            ),
            _buildWebWithTitle(
              context,
              PortfolioData.skillCategories[1],
              animation,
              index: 1,
            ),
            _buildWebWithTitle(
              context,
              PortfolioData.skillCategories[2],
              animation,
              index: 2,
            ),
            _buildWebWithTitle(
              context,
              PortfolioData.skillCategories[3],
              animation,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebWithTitle(
    BuildContext context,
    SkillCategory category,
    Animation<double> animation, {
    required int index,
  }) {
    return Column(
      children: [
        _buildCategoryHeader(context, category),
        const SizedBox(height: 30),
        FadeInUp(
          duration: const Duration(milliseconds: 1000),
          delay: Duration(milliseconds: index * 200),
          child: _WebMockup(category: category, animation: animation),
        ),
      ],
    );
  }

  Widget _buildCategoryHeader(BuildContext context, SkillCategory category) {
    final app_icon = _getCategoryIcon(category.title);
    const app_color = AppColors.gold;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: app_color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(app_icon, color: app_color, size: 20),
        ),
        const SizedBox(height: 10),
        Text(
          category.title.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: app_color,
            letterSpacing: 2,
          ),
        ),
      ],
    );
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
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: isDark
                  ? app_color.withValues(alpha: 0.02)
                  : app_color.withValues(alpha: 0.05),
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
                const SizedBox(height: 30),
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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? (parentHovered
                  ? app_color.withValues(alpha: 0.08)
                  : app_color.withValues(alpha: 0.04))
            : (parentHovered
                  ? app_color.withValues(alpha: 0.1)
                  : app_color.withValues(alpha: 0.05)),
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
          if (app_icon != null)
            Icon(app_icon, size: 18, color: app_color.withValues(alpha: 0.8)),
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

class _WebMockup extends StatelessWidget {
  final SkillCategory category;
  final Animation<double> animation;

  const _WebMockup({required this.category, required this.animation});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const app_color = AppColors.gold;

    return GetBuilder<SkillHoverController>(
      init: SkillHoverController(),
      tag: category.title,
      builder: (controller) {
        return MouseRegion(
          onEnter: (_) => controller.setHovered(true),
          onExit: (_) => controller.setHovered(false),
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final double scrollCycle = (animation.value * 4) % 1.0;
              final double curvedScroll = Curves.easeInOutQuart.transform(
                scrollCycle,
              );

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 320,
                height: 350,
                decoration: BoxDecoration(
                  color: isDark
                      ? app_color.withValues(alpha: 0.02)
                      : app_color.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: controller.isHovered
                        ? app_color
                        : app_color.withValues(alpha: 0.2),
                    width: controller.isHovered ? 2 : 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: app_color.withValues(
                        alpha: controller.isHovered ? 0.2 : 0.05,
                      ),
                      blurRadius: controller.isHovered ? 40 : 20,
                      spreadRadius: controller.isHovered ? 5 : 0,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    // Browser UI Header
                    _buildBrowserHeader(isDark, category.title),
                    // Content Area
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top:
                                -(curvedScroll * (category.skills.length * 60)),
                            child: Column(
                              children: [
                                ...category.skills.map(
                                  (skill) => _buildWebSkillItem(skill, isDark),
                                ),
                                // Loop content for smooth scrolling
                                ...category.skills.map(
                                  (skill) => _buildWebSkillItem(skill, isDark),
                                ),
                              ],
                            ),
                          ),
                          // Side scrollbar decoration
                          Positioned(
                            right: 2,
                            top: 10,
                            bottom: 10,
                            child: Container(
                              width: 3,
                              decoration: BoxDecoration(
                                color: app_color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBrowserHeader(bool isDark, String title) {
    const app_color = AppColors.gold;
    const app_icon_lock = AppIcons.auth;
    const app_icon_refresh = AppIcons.refresh;

    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111111) : const Color(0xFFF9FAFB),
        border: Border(
          bottom: BorderSide(color: app_color.withValues(alpha: 0.1), width: 1),
        ),
      ),
      child: Row(
        children: [
          _dot(app_color.withValues(alpha: 0.5)),
          _dot(app_color.withValues(alpha: 0.3)),
          _dot(app_color.withValues(alpha: 0.2)),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 18,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black
                    : app_color.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: app_color.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    app_icon_lock,
                    size: 8,
                    color: app_color.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${title.toLowerCase().replaceAll(' ', '-')}.io",
                    style: TextStyle(
                      fontSize: 9,
                      color: app_color.withValues(alpha: 0.6),
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          Icon(
            app_icon_refresh,
            size: 12,
            color: app_color.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
    width: 8,
    height: 8,
    margin: const EdgeInsets.only(right: 6),
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );

  Widget _buildWebSkillItem(Skill skill, bool isDark) {
    const app_color = AppColors.gold;
    final app_icon = skill.icon ?? Icons.code_rounded;
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: app_color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: app_color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(app_icon, color: app_color, size: 20),
          const SizedBox(width: 20),
          Text(
            skill.name,
            style: const TextStyle(
              color: app_color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 6,
            decoration: BoxDecoration(
              color: app_color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillHoverController extends GetxController {
  bool isHovered = false;

  void setHovered(bool val) {
    isHovered = val;
    update();
  }
}
