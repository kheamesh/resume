import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);
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
          const SizedBox(height: 60),
          ResponsiveLayout(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildContent(context)),
                const SizedBox(width: 80),
                Expanded(flex: 2, child: _buildStats(context)),
              ],
            ),
            mobile: Column(
              children: [
                _buildContent(context),
                const SizedBox(height: 60),
                _buildStats(context),
              ],
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
          AppStrings.aboutMe,
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

  Widget _buildContent(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutHeadline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          PortfolioData.aboutSummary,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          AppStrings.aboutPhilosophy,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        _StatCard(
          label: AppStrings.yearsExperience,
          value: PortfolioData.experienceYears,
        ),
        _StatCard(
          label: AppStrings.projectsCompleted,
          value: PortfolioData.projectsCompleted,
        ),
        _StatCard(
          label: AppStrings.technologies,
          value: PortfolioData.technologiesCount,
        ),
        _StatCard(
          label: AppStrings.clientsServed,
          value: PortfolioData.clientsServed,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? Colors.grey,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
