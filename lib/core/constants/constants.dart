import 'package:flutter/material.dart';

class AppConstants {
  static const double desktopPadding = 64.0;
  static const double tabletPadding = 32.0;
  static const double mobilePadding = 16.0;
  
  static const double maxContentWidth = 1200.0;
  
  static double getPadding(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 1200) return desktopPadding;
    if (MediaQuery.of(context).size.width >= 600) return tabletPadding;
    return mobilePadding;
  }
}
