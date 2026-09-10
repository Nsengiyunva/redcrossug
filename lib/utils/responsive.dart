import 'package:flutter/material.dart';

/// Lightweight, dependency-free responsive helpers shared across the app.
///
/// Note: these are deliberately NOT named `isTablet`/`isDesktop` — GetX
/// (`package:get`) already defines a `BuildContext.isTablet`/`isDesktop`
/// extension app-wide, and having two extensions with identically-named
/// members makes Dart unable to pick one ("defined in multiple
/// extensions... neither is more specific"). Using distinct names avoids
/// that entirely, with no need for explicit extension application.
///
/// Usage:
///   final pad = context.responsiveHorizontalPadding;
///   final size = context.scaledFont(16);
extension ResponsiveContext on BuildContext {
  Size get _size => MediaQuery.of(this).size;

  bool get isSmallPhoneWidth => _size.width < 340;
  bool get isTabletWidth => _size.width > 600;
  bool get isDesktopWidth => _size.width > 900;

  /// Horizontal padding that widens on larger screens instead of letting
  /// content stretch edge-to-edge on tablets/desktop web.
  double get responsiveHorizontalPadding {
    if (isDesktopWidth) return _size.width * 0.25;
    if (isTabletWidth) return 48.0;
    return 20.0;
  }

  /// Vertical padding for top-level scaffold content.
  double get responsiveVerticalPadding => isTabletWidth ? 48.0 : 24.0;

  /// Scales a base (phone) font size up slightly for tablets/desktop and
  /// down slightly on very small/old phones.
  double scaledFont(double base) {
    double factor = 1.0;
    if (isDesktopWidth) {
      factor = 1.15;
    } else if (isTabletWidth) {
      factor = 1.08;
    } else if (isSmallPhoneWidth) {
      factor = 0.94;
    }
    return base * factor;
  }

  /// A max content width for very wide screens (tablet/desktop/web) so
  /// forms and cards don't stretch uncomfortably wide.
  double get maxContentWidth =>
      isDesktopWidth ? 520.0 : (isTabletWidth ? 640.0 : double.infinity);
}
