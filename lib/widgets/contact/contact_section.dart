import 'package:flutter/material.dart';
import '../../core/constants/app_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 100),
      color: Colors.transparent,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 80),
          ResponsiveLayout(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildContactInfo(context)),
                const SizedBox(width: 100),
                Expanded(child: _buildContactForm(context)),
              ],
            ),
            mobile: Column(
              children: [
                _buildContactInfo(context),
                const SizedBox(height: 60),
                _buildContactForm(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          AppStrings.contactMe,
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          AppStrings.contactHeadline,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.contactSub,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 18, height: 1.6),
        ),
        const SizedBox(height: 50),
        _ContactItem(icon: AppIcons.email, label: AppStrings.labelEmail, value: PortfolioData.email),
        const SizedBox(height: 30),
        _ContactItem(icon: AppIcons.location, label: AppStrings.labelLocation, value: PortfolioData.location),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerTheme.color ?? Colors.grey, width: 0.5),
      ),
      child: Column(
        children: [
          _buildTextField(context, AppStrings.labelName),
          const SizedBox(height: 25),
          _buildTextField(context, AppStrings.labelEmail),
          const SizedBox(height: 25),
          _buildTextField(context, AppStrings.labelMessage, maxLines: 5),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(AppStrings.sendMessage, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Theme.of(context).textTheme.titleSmall?.color, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLines: maxLines,
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).dividerTheme.color ?? AppColors.darkBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).dividerTheme.color ?? AppColors.darkBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.gold),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactItem({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.gold),
        ),
        const SizedBox(width: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
