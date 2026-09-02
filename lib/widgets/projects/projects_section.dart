import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import '../../core/constants/app_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../models/project.dart';
import '../../controllers/projects_controller.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);
    final controller = Get.put(ProjectsController());
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 100),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 40),
          _buildFilters(context, controller),
          const SizedBox(height: 60),
          Obx(
            () => _buildFeaturedProjects(
              controller.filteredProjects.where((p) => p.isFeatured).toList(),
            ),
          ),
          const SizedBox(height: 60),
          Obx(
            () => _buildProjectGrid(
              context,
              controller.filteredProjects.where((p) => !p.isFeatured).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.portfolio,
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppStrings.featuredProjects,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context, ProjectsController controller) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: controller.categories.map((cat) {
        return Obx(() {
          bool isSelected = controller.selectedCategory.value == cat;
          return ChoiceChip(
            label: Text(cat),
            selected: isSelected,
            onSelected: (val) => controller.setCategory(cat),
            backgroundColor: Colors.transparent,
            selectedColor: AppColors.gold,
            labelStyle: TextStyle(
              color: isSelected
                  ? Colors.black
                  : Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: isSelected
                    ? AppColors.gold
                    : (Theme.of(context).dividerTheme.color ??
                          AppColors.darkBorder),
              ),
            ),
          );
        });
      }).toList(),
    );
  }

  Widget _buildFeaturedProjects(List<Project> projects) {
    return Column(
      children: projects
          .map(
            (project) => Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: FadeInUp(child: _FeaturedProjectCard(project: project)),
            ),
          )
          .toList(),
    );
  }

  Widget _buildProjectGrid(BuildContext context, List<Project> projects) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveLayout.isDesktop(context)
            ? 3
            : (ResponsiveLayout.isTablet(context) ? 2 : 1),
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: 100 * index),
          child: _ProjectGridCard(project: projects[index]),
        );
      },
    );
  }
}

class _FeaturedProjectCard extends StatelessWidget {
  final Project project;

  const _FeaturedProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? Colors.grey,
          width: 0.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: ResponsiveLayout(
        desktop: Row(
          children: [
            Expanded(flex: 3, child: _buildImage(context)),
            Expanded(flex: 2, child: _buildInfo(context)),
          ],
        ),
        mobile: Column(children: [_buildImage(context), _buildInfo(context)]),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Container(
      height: isMobile ? 250 : 450,
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Icon(
          AppIcons.laptop,
          size: isMobile ? 60 : 100,
          color: AppColors.gold.withValues(alpha: 0.1),
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Padding(
      padding: EdgeInsets.all(isMobile ? 25 : 50),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.featuredProjectSub,
            style: TextStyle(
              color: AppColors.gold,
              letterSpacing: 2,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            project.name,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.displayLarge?.color,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            project.description,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 10,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: project.technologies
                .map(
                  (tech) => Text(
                    "#$tech",
                    style: const TextStyle(
                      color: AppColors.goldAccent,
                      fontSize: 14,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (project.githubUrl != null)
                IconButton(icon: const Icon(AppIcons.code), onPressed: () {}),
              if (project.liveUrl != null)
                IconButton(icon: const Icon(AppIcons.launch), onPressed: () {}),
              if (!isMobile) const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  AppStrings.viewCaseStudy,
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectGridCard extends StatelessWidget {
  final Project project;

  const _ProjectGridCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final hoverController = Get.put(
      ProjectHoverController(),
      tag: project.name,
    );

    return MouseRegion(
      onEnter: (_) => hoverController.setHover(true),
      onExit: (_) => hoverController.setHover(false),
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hoverController.isHovered.value
                  ? AppColors.gold
                  : (Theme.of(context).dividerTheme.color ?? Colors.grey),
              width: 0.5,
            ),
            boxShadow: hoverController.isHovered.value
                ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ]
                : [],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  width: double.infinity,
                  child: Icon(
                    AppIcons.image,
                    size: 50,
                    color: AppColors.gold.withValues(alpha: 0.1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      project.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          project.category ?? "App",
                          style: const TextStyle(
                            color: AppColors.gold,
                            fontSize: 12,
                          ),
                        ),
                        const Icon(
                          AppIcons.arrowForward,
                          size: 16,
                          color: AppColors.gold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectHoverController extends GetxController {
  var isHovered = false.obs;

  void setHover(bool val) => isHovered.value = val;
}
