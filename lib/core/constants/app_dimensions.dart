/// AppDimensions — Layout constants prioritizing 56dp touch targets and accessibility.
abstract class AppDimensions {
  // Touch Targets (Mandatory minimum 56dp)
  static const double minTouchTarget = 56.0;
  static const double largeTouchTarget = 72.0;

  // Spacing & Padding
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;

  // Typography Sizes
  static const double fontL = 20.0;
  static const double fontXL = 28.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 16.0;
  static const double radiusL = 24.0;
  static const double radiusRound = 999.0;

  // Card Elevation
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;

  // Icon Sizes
  static const double iconSmall = 24.0;
  static const double iconMedium = 36.0;
  static const double iconLarge = 48.0;
  static const double iconHuge = 64.0;
}
