import 'package:flutter/material.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../data/portfolio_data.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 100),
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 60),
          _buildTimeline(context),
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
          AppStrings.experience,
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 50,
          height: 2,
          color: AppColors.gold,
        ),
      ],
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: PortfolioData.experiences.length,
      itemBuilder: (ctx, index) {
        final exp = PortfolioData.experiences[index];
        return IntrinsicHeight(
          child: Row(
            children: [
              if (!isMobile) ...[
                _buildTimelineIndicator(ctx, index == PortfolioData.experiences.length - 1),
                const SizedBox(width: 30),
              ],
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: _buildExperienceCard(ctx, exp),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimelineIndicator(BuildContext context, bool isLast) {
    return Column(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: AppColors.gold,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.5),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        if (!isLast)
          Expanded(
            child: Container(
              width: 1,
              color: Theme.of(context).dividerTheme.color,
            ),
          ),
      ],
    );
  }

  Widget _buildExperienceCard(BuildContext context, dynamic exp) {
    final isMobile = ResponsiveLayout.isMobile(context);
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 25 : 40),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerTheme.color ?? Colors.grey, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile) ...[
            Text(
              exp.role,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              exp.company,
              style: const TextStyle(fontSize: 16, color: AppColors.goldAccent),
            ),
            const SizedBox(height: 10),
            Text(
              exp.duration,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 14),
            ),
            Text(
              exp.location,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12),
            ),
          ] else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp.role,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      exp.company,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.goldAccent,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      exp.duration,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      exp.location,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 30),
          ...exp.responsibilities.map((res) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• ", style: TextStyle(color: AppColors.gold)),
                Expanded(
                  child: Text(
                    res,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.8),
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
          const SizedBox(height: 30),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: exp.technologies.map<Widget>((tech) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.gold.withValues(alpha: 0.3), width: 0.5),
              ),
              child: Text(
                tech,
                style: const TextStyle(fontSize: 12, color: AppColors.gold),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
