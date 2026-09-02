import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 100),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 80),
          ResponsiveLayout(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: PortfolioData.processSteps.asMap().entries.map((entry) {
                return Expanded(
                  child: _buildProcessStep(
                    context: context,
                    index: entry.key + 1,
                    title: entry.value['title']!,
                    desc: entry.value['desc']!,
                  ),
                );
              }).toList(),
            ),
            mobile: Column(
              children: PortfolioData.processSteps.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: _buildProcessStep(
                    context: context,
                    index: entry.key + 1,
                    title: entry.value['title']!,
                    desc: entry.value['desc']!,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.howIWork,
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppStrings.processHeadline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProcessStep({required BuildContext context, required int index, required String title, required String desc}) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            "0$index",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: AppColors.gold.withValues(alpha: 0.1),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            desc,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
