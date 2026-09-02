import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../data/portfolio_data.dart';
import 'tech_visual.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = AppConstants.getPadding(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height),
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: isMobile ? 120 : 0,
      ),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ResponsiveLayout(
        desktop: _buildDesktop(context),
        mobile: _buildMobile(context),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildInfo(context)),
        const SizedBox(width: 40),
        Expanded(flex: 2, child: _buildVisual(context)),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        _buildInfo(context),
        const SizedBox(height: 60),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: TechVisual(),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildInfo(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    ResponsiveLayout.isMobile(context);
    final useNarrowStyling = !isDesktop;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: useNarrowStyling
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(useNarrowStyling ? 25 : 45),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color:
                  Theme.of(context).dividerTheme.color ??
                  Colors.grey.withValues(alpha: 0.2),
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: useNarrowStyling
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: Text(
                  AppStrings.helloIm,
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 4,
                    fontSize: useNarrowStyling ? 14 : 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInLeft(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: useNarrowStyling
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: Text(
                    PortfolioData.name,
                    textAlign: useNarrowStyling
                        ? TextAlign.center
                        : TextAlign.start,
                    style: TextStyle(
                      fontSize: useNarrowStyling ? 48 : 80,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInLeft(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 400),
                child: Text(
                  PortfolioData.role,
                  style: TextStyle(
                    fontSize: useNarrowStyling ? 18 : 24,
                    color: AppColors.goldAccent,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 600),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    PortfolioData.shortIntro,
                    textAlign: useNarrowStyling
                        ? TextAlign.center
                        : TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 800),
          child: _buildCTAs(context),
        ),
        const SizedBox(height: 40),
        FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 1000),
          child: _buildSocials(context),
        ),
      ],
    );
  }

  Widget _buildCTAs(BuildContext context) {
    final useNarrowStyling = !ResponsiveLayout.isDesktop(context);
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: useNarrowStyling ? WrapAlignment.center : WrapAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gold,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            AppStrings.viewMyWork,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
            side: const BorderSide(color: AppColors.gold),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            AppStrings.downloadCv,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildSocials(BuildContext context) {
    final useNarrowStyling = !ResponsiveLayout.isDesktop(context);
    return Row(
      mainAxisAlignment: useNarrowStyling
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        _SocialIcon(icon: AppIcons.github, url: PortfolioData.github),
        const SizedBox(width: 20),
        _SocialIcon(icon: AppIcons.linkedin, url: PortfolioData.linkedin),
        const SizedBox(width: 20),
        _SocialIcon(icon: AppIcons.email, url: "mailto:${PortfolioData.email}"),
      ],
    );
  }

  Widget _buildVisual(BuildContext context) {
    return FadeInRight(
      duration: Duration(milliseconds: 1000),
      child: Center(child: TechVisual()),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: 24,
        ),
      ),
    );
  }
}
