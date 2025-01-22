import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff845416),
      surfaceTint: Color(0xff845416),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdcbb),
      onPrimaryContainer: Color(0xff2b1700),
      secondary: Color(0xff725a41),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffeddbd),
      onSecondaryContainer: Color(0xff281805),
      tertiary: Color(0xff56633b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdae9b6),
      onTertiaryContainer: Color(0xff141f01),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffff8f4),
      onBackground: Color(0xff211a14),
      surface: Color(0xfffff8f4),
      onSurface: Color(0xff211a14),
      surfaceVariant: Color(0xfff1dfd0),
      onSurfaceVariant: Color(0xff50453a),
      outline: Color(0xff827568),
      outlineVariant: Color(0xffd4c4b5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff372f27),
      inverseOnSurface: Color(0xfffdeee3),
      inversePrimary: Color(0xfffaba73),
      primaryFixed: Color(0xffffdcbb),
      onPrimaryFixed: Color(0xff2b1700),
      primaryFixedDim: Color(0xfffaba73),
      onPrimaryFixedVariant: Color(0xff673d00),
      secondaryFixed: Color(0xfffeddbd),
      onSecondaryFixed: Color(0xff281805),
      secondaryFixedDim: Color(0xffe0c1a3),
      onSecondaryFixedVariant: Color(0xff58432c),
      tertiaryFixed: Color(0xffdae9b6),
      onTertiaryFixed: Color(0xff141f01),
      tertiaryFixedDim: Color(0xffbecc9c),
      onTertiaryFixedVariant: Color(0xff3f4b26),
      surfaceDim: Color(0xffe6d8cc),
      surfaceBright: Color(0xfffff8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfffaebe0),
      surfaceContainerHigh: Color(0xfff4e6da),
      surfaceContainerHighest: Color(0xffeee0d5),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff623900),
      surfaceTint: Color(0xff845416),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9e692a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff543f28),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff897056),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3b4722),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6c7a50),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f4),
      onBackground: Color(0xff211a14),
      surface: Color(0xfffff8f4),
      onSurface: Color(0xff211a14),
      surfaceVariant: Color(0xfff1dfd0),
      onSurfaceVariant: Color(0xff4c4136),
      outline: Color(0xff6a5d51),
      outlineVariant: Color(0xff86786c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff372f27),
      inverseOnSurface: Color(0xfffdeee3),
      inversePrimary: Color(0xfffaba73),
      primaryFixed: Color(0xff9e692a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff815113),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff897056),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6f583f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6c7a50),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff546139),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe6d8cc),
      surfaceBright: Color(0xfffff8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfffaebe0),
      surfaceContainerHigh: Color(0xfff4e6da),
      surfaceContainerHighest: Color(0xffeee0d5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff351d00),
      surfaceTint: Color(0xff845416),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff623900),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff301f0b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff543f28),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1b2605),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3b4722),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f4),
      onBackground: Color(0xff211a14),
      surface: Color(0xfffff8f4),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xfff1dfd0),
      onSurfaceVariant: Color(0xff2c2219),
      outline: Color(0xff4c4136),
      outlineVariant: Color(0xff4c4136),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff372f27),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffffe8d4),
      primaryFixed: Color(0xff623900),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff432600),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff543f28),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3c2914),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3b4722),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff25300e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe6d8cc),
      surfaceBright: Color(0xfffff8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfffaebe0),
      surfaceContainerHigh: Color(0xfff4e6da),
      surfaceContainerHighest: Color(0xffeee0d5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffaba73),
      surfaceTint: Color(0xfffaba73),
      onPrimary: Color(0xff482900),
      primaryContainer: Color(0xff673d00),
      onPrimaryContainer: Color(0xffffdcbb),
      secondary: Color(0xffe0c1a3),
      onSecondary: Color(0xff402d17),
      secondaryContainer: Color(0xff58432c),
      onSecondaryContainer: Color(0xfffeddbd),
      tertiary: Color(0xffbecc9c),
      onTertiary: Color(0xff293411),
      tertiaryContainer: Color(0xff3f4b26),
      onTertiaryContainer: Color(0xffdae9b6),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff19120c),
      onBackground: Color(0xffeee0d5),
      surface: Color(0xff19120c),
      onSurface: Color(0xffeee0d5),
      surfaceVariant: Color(0xff50453a),
      onSurfaceVariant: Color(0xffd4c4b5),
      outline: Color(0xff9d8e81),
      outlineVariant: Color(0xff50453a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeee0d5),
      inverseOnSurface: Color(0xff372f27),
      inversePrimary: Color(0xff845416),
      primaryFixed: Color(0xffffdcbb),
      onPrimaryFixed: Color(0xff2b1700),
      primaryFixedDim: Color(0xfffaba73),
      onPrimaryFixedVariant: Color(0xff673d00),
      secondaryFixed: Color(0xfffeddbd),
      onSecondaryFixed: Color(0xff281805),
      secondaryFixedDim: Color(0xffe0c1a3),
      onSecondaryFixedVariant: Color(0xff58432c),
      tertiaryFixed: Color(0xffdae9b6),
      onTertiaryFixed: Color(0xff141f01),
      tertiaryFixedDim: Color(0xffbecc9c),
      onTertiaryFixedVariant: Color(0xff3f4b26),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff403830),
      surfaceContainerLowest: Color(0xff130d07),
      surfaceContainerLow: Color(0xff211a14),
      surfaceContainer: Color(0xff251e17),
      surfaceContainerHigh: Color(0xff302921),
      surfaceContainerHighest: Color(0xff3b332c),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffbe77),
      surfaceTint: Color(0xfffaba73),
      onPrimary: Color(0xff241200),
      primaryContainer: Color(0xffbe8543),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe5c5a7),
      onSecondary: Color(0xff221302),
      secondaryContainer: Color(0xffa78c70),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffc2d1a0),
      onTertiary: Color(0xff101900),
      tertiaryContainer: Color(0xff88966a),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff19120c),
      onBackground: Color(0xffeee0d5),
      surface: Color(0xff19120c),
      onSurface: Color(0xfffffaf8),
      surfaceVariant: Color(0xff50453a),
      onSurfaceVariant: Color(0xffd9c8b9),
      outline: Color(0xffb0a092),
      outlineVariant: Color(0xff8f8174),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeee0d5),
      inverseOnSurface: Color(0xff302921),
      inversePrimary: Color(0xff693e00),
      primaryFixed: Color(0xffffdcbb),
      onPrimaryFixed: Color(0xff1d0e00),
      primaryFixedDim: Color(0xfffaba73),
      onPrimaryFixedVariant: Color(0xff502e00),
      secondaryFixed: Color(0xfffeddbd),
      onSecondaryFixed: Color(0xff1c0e01),
      secondaryFixedDim: Color(0xffe0c1a3),
      onSecondaryFixedVariant: Color(0xff46321d),
      tertiaryFixed: Color(0xffdae9b6),
      onTertiaryFixed: Color(0xff0b1400),
      tertiaryFixedDim: Color(0xffbecc9c),
      onTertiaryFixedVariant: Color(0xff2f3a17),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff403830),
      surfaceContainerLowest: Color(0xff130d07),
      surfaceContainerLow: Color(0xff211a14),
      surfaceContainer: Color(0xff251e17),
      surfaceContainerHigh: Color(0xff302921),
      surfaceContainerHighest: Color(0xff3b332c),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffffaf8),
      surfaceTint: Color(0xfffaba73),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffbe77),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe5c5a7),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff6ffda),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc2d1a0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff19120c),
      onBackground: Color(0xffeee0d5),
      surface: Color(0xff19120c),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff50453a),
      onSurfaceVariant: Color(0xfffffaf8),
      outline: Color(0xffd9c8b9),
      outlineVariant: Color(0xffd9c8b9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeee0d5),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff402400),
      primaryFixed: Color(0xffffe2c7),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffbe77),
      onPrimaryFixedVariant: Color(0xff241200),
      secondaryFixed: Color(0xffffe2c7),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe5c5a7),
      onSecondaryFixedVariant: Color(0xff221302),
      tertiaryFixed: Color(0xffdeedba),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc2d1a0),
      onTertiaryFixedVariant: Color(0xff101900),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff403830),
      surfaceContainerLowest: Color(0xff130d07),
      surfaceContainerLow: Color(0xff211a14),
      surfaceContainer: Color(0xff251e17),
      surfaceContainerHigh: Color(0xff302921),
      surfaceContainerHighest: Color(0xff3b332c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


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


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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
