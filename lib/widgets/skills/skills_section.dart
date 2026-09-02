import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';
import '../../controllers/background_controller.dart';
import '../../core/constants/app_icons.dart';
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

  Widget _buildDecorativeRings(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: animation.value * 2 * pi,
          child: Opacity(
            opacity: 0.03,
            child: Icon(
              Icons.blur_circular_rounded,
              size: 800,
              color: AppColors.gold,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    Animation<double> animation,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMobileWithTitle(
                  context,
                  PortfolioData.skillCategories[0],
                  animation,
                  index: 0,
                ),
                _buildMobileWithTitle(
                  context,
                  PortfolioData.skillCategories[1],
                  animation,
                  index: 1,
                ),
                _buildMobileWithTitle(
                  context,
                  PortfolioData.skillCategories[2],
                  animation,
                  index: 2,
                ),
                _buildMobileWithTitle(
                  context,
                  PortfolioData.skillCategories[3],
                  animation,
                  index: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileWithTitle(
    BuildContext context,
    SkillCategory category,
    Animation<double> animation, {
    required int index,
  }) {
    final isLeft = index % 2 == 0;
    return Column(
      children: [
        _buildCategoryHeader(context, category),
        const SizedBox(height: 30),
        isLeft
            ? FadeInLeft(
                duration: const Duration(milliseconds: 1000),
                delay: Duration(milliseconds: index * 200),
                child: _MobileMockup(category: category, animation: animation),
              )
            : FadeInRight(
                duration: const Duration(milliseconds: 1000),
                delay: Duration(milliseconds: index * 200),
                child: _MobileMockup(category: category, animation: animation),
              ),
      ],
    );
  }

  Widget _buildCategoryHeader(BuildContext context, SkillCategory category) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getCategoryIcon(category.title),
            color: AppColors.gold,
            size: 20,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          category.title.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: AppColors.gold,
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

  Widget _buildSkillCategory(BuildContext context, SkillCategory category) {
    return _buildSkillCategoryCard(context, category);
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.skillsAndTech,
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 10),
        Container(width: 50, height: 2, color: AppColors.gold),
      ],
    );
  }

  Widget _buildSkillCategoryCard(BuildContext context, SkillCategory category) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              color: isDark ? const Color(0xFF0A0A0A) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: controller.isHovered
                    ? AppColors.gold
                    : AppColors.gold.withValues(alpha: 0.15),
                width: controller.isHovered ? 1.5 : 0.5,
              ),
              boxShadow: [
                if (controller.isHovered)
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.2),
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
                            ? AppColors.gold.withValues(alpha: 0.2)
                            : AppColors.gold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(category.title),
                        color: AppColors.gold,
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
    if (title.contains("Mobile")) return Icons.phone_android_rounded;
    if (title.contains("State")) return Icons.account_tree_rounded;
    if (title.contains("Backend")) return Icons.cloud_queue_rounded;
    if (title.contains("Tools")) return Icons.architecture_rounded;
    return Icons.code_rounded;
  }

  Widget _buildSkillChip(
    BuildContext context,
    Skill skill,
    bool parentHovered,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? (parentHovered
                  ? const Color(0xFF151515)
                  : const Color(0xFF111111))
            : (parentHovered
                  ? const Color(0xFFF9FAFB)
                  : const Color(0xFFF3F4F6)),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: parentHovered
              ? AppColors.gold.withValues(alpha: 0.3)
              : AppColors.gold.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (skill.icon != null)
            Icon(
              skill.icon,
              size: 18,
              color: AppColors.gold.withValues(alpha: 0.8),
            ),
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

class _MobileMockup extends StatelessWidget {
  final SkillCategory category;
  final Animation<double> animation;

  const _MobileMockup({required this.category, required this.animation});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              final double slideCycle = (animation.value * 5) % 1.0;
              final double curvedSlide = Curves.easeInOutCubic.transform(
                slideCycle,
              );

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 220,
                height: 440,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF030303) : Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(
                    color: controller.isHovered
                        ? AppColors.gold
                        : AppColors.gold.withValues(alpha: 0.3),
                    width: controller.isHovered ? 3 : 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(
                        alpha: controller.isHovered ? 0.25 : 0.1,
                      ),
                      blurRadius: controller.isHovered ? 40 : 20,
                      spreadRadius: controller.isHovered ? 5 : 0,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    // Screen Content
                    Positioned(
                      left: 0,
                      right: 0,
                      top: -(curvedSlide * (category.skills.length * 40)),
                      child: Column(
                        children: [
                          ...category.skills.map(
                            (skill) => _buildSkillItem(skill, isDark),
                          ),
                          // Loop content for smooth scrolling
                          ...category.skills.map(
                            (skill) => _buildSkillItem(skill, isDark),
                          ),
                        ],
                      ),
                    ),
                    // Hardware Gloss
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.05),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.05),
                            ],
                            stops: const [0, 0.5, 1],
                          ),
                        ),
                      ),
                    ),
                    // Notch
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 85,
                        height: 25,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1A1A1A)
                              : const Color(0xFFE5E7EB),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 30,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
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

  Widget _buildSkillItem(Skill skill, bool isDark) {
    return Container(
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              skill.icon ?? AppIcons.rocket,
              color: AppColors.gold,
              size: 18,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skill.name.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 30,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ],
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
