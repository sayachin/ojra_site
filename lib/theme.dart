import 'package:flutter/material.dart';

/// New Age Factories visual language.
class Brand {
  Brand._();

  static const bg = Color(0xFF05070E);
  static const bgSoft = Color(0xFF070A13);
  static const surface = Color(0xFF0B0F1A);
  static const surfaceRaised = Color(0xFF101624);
  static const line = Color(0x14FFFFFF);
  static const lineStrong = Color(0x26FFFFFF);

  static const ink = Color(0xFFF4F7FF);
  static const muted = Color(0xFF96A2B8);
  static const dim = Color(0xFF5F6B82);

  static const cyan = Color(0xFF46E7FF);
  static const blue = Color(0xFF5A8BFF);
  static const violet = Color(0xFF8B6CFF);
  static const magenta = Color(0xFFFF5FA2);
  static const lime = Color(0xFFBEFF69);
  static const ojra = Color(0xFFE62E6E);

  static const signature = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cyan, violet, magenta],
  );

  static const signatureSoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x3346E7FF), Color(0x338B6CFF), Color(0x22FF5FA2)],
  );

  static const surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D1320), Color(0xFF080B14)],
  );

  static const ojraGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF880E4F), Color(0xFFC2185B), Color(0xFFFF5F8F)],
  );
}

class T {
  T._();

  static const displayFamily = 'SpaceGrotesk';
  static const bodyFamily = 'Inter';
  static const monoFamily = 'JetBrainsMono';

  static TextStyle display(
    double size, {
    FontWeight weight = FontWeight.w600,
    double? height,
    Color color = Brand.ink,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: displayFamily,
      fontSize: size,
      fontWeight: weight,
      height: height ?? 1.02,
      letterSpacing: letterSpacing ?? -(size * 0.035),
      color: color,
    );
  }

  static TextStyle body(
    double size, {
    FontWeight weight = FontWeight.w400,
    double? height,
    Color color = Brand.muted,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: bodyFamily,
      fontSize: size,
      fontWeight: weight,
      height: height ?? 1.6,
      letterSpacing: letterSpacing ?? 0,
      color: color,
    );
  }

  static TextStyle mono(
    double size, {
    FontWeight weight = FontWeight.w500,
    Color color = Brand.muted,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: monoFamily,
      fontSize: size,
      fontWeight: weight,
      letterSpacing: letterSpacing ?? 1.6,
      height: height ?? 1.4,
      color: color,
    );
  }
}

ThemeData buildTheme() {
  const scheme = ColorScheme.dark(
    primary: Brand.cyan,
    onPrimary: Color(0xFF021018),
    secondary: Brand.violet,
    onSecondary: Colors.white,
    surface: Brand.surface,
    onSurface: Brand.ink,
    error: Brand.magenta,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: Brand.bg,
    canvasColor: Brand.bg,
    fontFamily: T.bodyFamily,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Brand.cyan,
      selectionColor: Color(0x5546E7FF),
      selectionHandleColor: Brand.cyan,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thickness: WidgetStateProperty.all(5),
      radius: const Radius.circular(10),
      thumbColor: WidgetStateProperty.all(const Color(0x336F7F9A)),
      crossAxisMargin: 2,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: Brand.surfaceRaised,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Brand.lineStrong),
      ),
      textStyle: T.body(12, color: Brand.ink),
      waitDuration: const Duration(milliseconds: 400),
    ),
  );
}

double gutterFor(double width) {
  if (width >= 1280) return 64;
  if (width >= 900) return 48;
  if (width >= 600) return 32;
  return 20;
}

const double kMaxContentWidth = 1240;

class Breakpoints {
  Breakpoints._();

  static bool mobile(double w) => w < 720;
  static bool tablet(double w) => w >= 720 && w < 1080;
  static bool desktop(double w) => w >= 1080;
}
