import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff7a580c),
      surfaceTint: Color(0xff7a580c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdea7),
      onPrimaryContainer: Color(0xff5e4200),
      secondary: Color(0xff36693e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb7f1ba),
      onSecondaryContainer: Color(0xff1d5128),
      tertiary: Color(0xff4d6544),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcfebc1),
      onTertiaryContainer: Color(0xff354d2e),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f3),
      onSurface: Color(0xff201b13),
      onSurfaceVariant: Color(0xff4e4639),
      outline: Color(0xff807667),
      outlineVariant: Color(0xffd1c5b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff353027),
      inversePrimary: Color(0xffedc06c),
      primaryFixed: Color(0xffffdea7),
      onPrimaryFixed: Color(0xff271900),
      primaryFixedDim: Color(0xffedc06c),
      onPrimaryFixedVariant: Color(0xff5e4200),
      secondaryFixed: Color(0xffb7f1ba),
      onSecondaryFixed: Color(0xff002109),
      secondaryFixedDim: Color(0xff9cd49f),
      onSecondaryFixedVariant: Color(0xff1d5128),
      tertiaryFixed: Color(0xffcfebc1),
      onTertiaryFixed: Color(0xff0b2007),
      tertiaryFixedDim: Color(0xffb3cea6),
      onTertiaryFixedVariant: Color(0xff354d2e),
      surfaceDim: Color(0xffe3d8cc),
      surfaceBright: Color(0xfffff8f3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffdf2e5),
      surfaceContainer: Color(0xfff7ecdf),
      surfaceContainerHigh: Color(0xfff1e7d9),
      surfaceContainerHighest: Color(0xffece1d4),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff493200),
      surfaceTint: Color(0xff7a580c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff8b671c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff073f19),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff44784c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff253c1f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5b7452),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f3),
      onSurface: Color(0xff151109),
      onSurfaceVariant: Color(0xff3d3529),
      outline: Color(0xff5a5144),
      outlineVariant: Color(0xff756c5d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff353027),
      inversePrimary: Color(0xffedc06c),
      primaryFixed: Color(0xff8b671c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff704f01),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff44784c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2c5f35),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5b7452),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff435b3b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcfc5b8),
      surfaceBright: Color(0xfffff8f3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffdf2e5),
      surfaceContainer: Color(0xfff1e7d9),
      surfaceContainerHigh: Color(0xffe6dbce),
      surfaceContainerHighest: Color(0xffdad0c3),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3c2900),
      surfaceTint: Color(0xff7a580c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff614400),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003412),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff1f532a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1b3116),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff384f30),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f3),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff322b20),
      outlineVariant: Color(0xff50483b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff353027),
      inversePrimary: Color(0xffedc06c),
      primaryFixed: Color(0xff614400),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff442f00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff1f532a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff023c16),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff384f30),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff22381c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc1b7ab),
      surfaceBright: Color(0xfffff8f3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffaefe2),
      surfaceContainer: Color(0xffece1d4),
      surfaceContainerHigh: Color(0xffddd3c6),
      surfaceContainerHighest: Color(0xffcfc5b8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffedc06c),
      surfaceTint: Color(0xffedc06c),
      onPrimary: Color(0xff412d00),
      primaryContainer: Color(0xff5e4200),
      onPrimaryContainer: Color(0xffffdea7),
      secondary: Color(0xff9cd49f),
      onSecondary: Color(0xff003914),
      secondaryContainer: Color(0xff1d5128),
      onSecondaryContainer: Color(0xffb7f1ba),
      tertiary: Color(0xffb3cea6),
      onTertiary: Color(0xff203619),
      tertiaryContainer: Color(0xff354d2e),
      onTertiaryContainer: Color(0xffcfebc1),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff17130b),
      onSurface: Color(0xffece1d4),
      onSurfaceVariant: Color(0xffd1c5b4),
      outline: Color(0xff9a8f80),
      outlineVariant: Color(0xff4e4639),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffece1d4),
      inversePrimary: Color(0xff7a580c),
      primaryFixed: Color(0xffffdea7),
      onPrimaryFixed: Color(0xff271900),
      primaryFixedDim: Color(0xffedc06c),
      onPrimaryFixedVariant: Color(0xff5e4200),
      secondaryFixed: Color(0xffb7f1ba),
      onSecondaryFixed: Color(0xff002109),
      secondaryFixedDim: Color(0xff9cd49f),
      onSecondaryFixedVariant: Color(0xff1d5128),
      tertiaryFixed: Color(0xffcfebc1),
      onTertiaryFixed: Color(0xff0b2007),
      tertiaryFixedDim: Color(0xffb3cea6),
      onTertiaryFixedVariant: Color(0xff354d2e),
      surfaceDim: Color(0xff17130b),
      surfaceBright: Color(0xff3e382f),
      surfaceContainerLowest: Color(0xff120e07),
      surfaceContainerLow: Color(0xff201b13),
      surfaceContainer: Color(0xff241f17),
      surfaceContainerHigh: Color(0xff2f2921),
      surfaceContainerHighest: Color(0xff3a342b),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd790),
      surfaceTint: Color(0xffedc06c),
      onPrimary: Color(0xff342300),
      primaryContainer: Color(0xffb28a3d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb1eab4),
      onSecondary: Color(0xff002d0e),
      secondaryContainer: Color(0xff679d6d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffc8e4bb),
      onTertiary: Color(0xff152b10),
      tertiaryContainer: Color(0xff7e9873),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff17130b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe8dac9),
      outline: Color(0xffbcb0a0),
      outlineVariant: Color(0xff9a8f7f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffece1d4),
      inversePrimary: Color(0xff5f4300),
      primaryFixed: Color(0xffffdea7),
      onPrimaryFixed: Color(0xff1a0f00),
      primaryFixedDim: Color(0xffedc06c),
      onPrimaryFixedVariant: Color(0xff493200),
      secondaryFixed: Color(0xffb7f1ba),
      onSecondaryFixed: Color(0xff001504),
      secondaryFixedDim: Color(0xff9cd49f),
      onSecondaryFixedVariant: Color(0xff073f19),
      tertiaryFixed: Color(0xffcfebc1),
      onTertiaryFixed: Color(0xff021501),
      tertiaryFixedDim: Color(0xffb3cea6),
      onTertiaryFixedVariant: Color(0xff253c1f),
      surfaceDim: Color(0xff17130b),
      surfaceBright: Color(0xff4a443a),
      surfaceContainerLowest: Color(0xff0a0703),
      surfaceContainerLow: Color(0xff221d15),
      surfaceContainer: Color(0xff2c271f),
      surfaceContainerHigh: Color(0xff383229),
      surfaceContainerHighest: Color(0xff433d34),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffeed5),
      surfaceTint: Color(0xffedc06c),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffe9bc69),
      onPrimaryContainer: Color(0xff120a00),
      secondary: Color(0xffc4fec7),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff98d09c),
      onSecondaryContainer: Color(0xff000f03),
      tertiary: Color(0xffdcf8ce),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffafcaa3),
      onTertiaryContainer: Color(0xff000f00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff17130b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfffceedc),
      outlineVariant: Color(0xffcdc1b0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffece1d4),
      inversePrimary: Color(0xff5f4300),
      primaryFixed: Color(0xffffdea7),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffedc06c),
      onPrimaryFixedVariant: Color(0xff1a0f00),
      secondaryFixed: Color(0xffb7f1ba),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff9cd49f),
      onSecondaryFixedVariant: Color(0xff001504),
      tertiaryFixed: Color(0xffcfebc1),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb3cea6),
      onTertiaryFixedVariant: Color(0xff021501),
      surfaceDim: Color(0xff17130b),
      surfaceBright: Color(0xff564f45),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff241f17),
      surfaceContainer: Color(0xff353027),
      surfaceContainerHigh: Color(0xff413b31),
      surfaceContainerHighest: Color(0xff4c463c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  // Aqui que eu defino algumas cores padrão para os widgets
  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
