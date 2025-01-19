import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff725c0c),
      surfaceTint: Color(0xff725c0c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffe087),
      onPrimaryContainer: Color(0xff231a00),
      secondary: Color(0xff695d3f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff1e1bb),
      onSecondaryContainer: Color(0xff221b04),
      tertiary: Color(0xff46664b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc8ecca),
      onTertiaryContainer: Color(0xff03210c),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffff8f0),
      onBackground: Color(0xff1f1b13),
      surface: Color(0xfffff8f0),
      onSurface: Color(0xff1f1b13),
      surfaceVariant: Color(0xffebe1cf),
      onSurfaceVariant: Color(0xff4c4639),
      outline: Color(0xff7d7667),
      outlineVariant: Color(0xffcfc6b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff343027),
      inverseOnSurface: Color(0xfff8f0e2),
      inversePrimary: Color(0xffe2c46d),
      primaryFixed: Color(0xffffe087),
      onPrimaryFixed: Color(0xff231a00),
      primaryFixedDim: Color(0xffe2c46d),
      onPrimaryFixedVariant: Color(0xff574500),
      secondaryFixed: Color(0xfff1e1bb),
      onSecondaryFixed: Color(0xff221b04),
      secondaryFixedDim: Color(0xffd4c5a1),
      onSecondaryFixedVariant: Color(0xff50462a),
      tertiaryFixed: Color(0xffc8ecca),
      onTertiaryFixed: Color(0xff03210c),
      tertiaryFixedDim: Color(0xffaccfaf),
      onTertiaryFixedVariant: Color(0xff2f4e34),
      surfaceDim: Color(0xffe1d9cc),
      surfaceBright: Color(0xfffff8f0),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffbf3e5),
      surfaceContainer: Color(0xfff5eddf),
      surfaceContainerHigh: Color(0xffefe7d9),
      surfaceContainerHighest: Color(0xffeae2d4),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff524100),
      surfaceTint: Color(0xff725c0c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff8a7223),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff4c4226),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff807454),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2b4931),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5c7c60),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f0),
      onBackground: Color(0xff1f1b13),
      surface: Color(0xfffff8f0),
      onSurface: Color(0xff1f1b13),
      surfaceVariant: Color(0xffebe1cf),
      onSurfaceVariant: Color(0xff484235),
      outline: Color(0xff655e50),
      outlineVariant: Color(0xff817a6b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff343027),
      inverseOnSurface: Color(0xfff8f0e2),
      inversePrimary: Color(0xffe2c46d),
      primaryFixed: Color(0xff8a7223),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff6f5a09),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff807454),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff665b3d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5c7c60),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff446349),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe1d9cc),
      surfaceBright: Color(0xfffff8f0),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffbf3e5),
      surfaceContainer: Color(0xfff5eddf),
      surfaceContainerHigh: Color(0xffefe7d9),
      surfaceContainerHighest: Color(0xffeae2d4),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff2b2100),
      surfaceTint: Color(0xff725c0c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff524100),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff292109),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4c4226),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff092812),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2b4931),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f0),
      onBackground: Color(0xff1f1b13),
      surface: Color(0xfffff8f0),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffebe1cf),
      onSurfaceVariant: Color(0xff282418),
      outline: Color(0xff484235),
      outlineVariant: Color(0xff484235),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff343027),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffffebb6),
      primaryFixed: Color(0xff524100),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff382b00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4c4226),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff342c12),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff2b4931),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff15331c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe1d9cc),
      surfaceBright: Color(0xfffff8f0),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffbf3e5),
      surfaceContainer: Color(0xfff5eddf),
      surfaceContainerHigh: Color(0xffefe7d9),
      surfaceContainerHighest: Color(0xffeae2d4),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe2c46d),
      surfaceTint: Color(0xffe2c46d),
      onPrimary: Color(0xff3c2f00),
      primaryContainer: Color(0xff574500),
      onPrimaryContainer: Color(0xffffe087),
      secondary: Color(0xffd4c5a1),
      onSecondary: Color(0xff383016),
      secondaryContainer: Color(0xff50462a),
      onSecondaryContainer: Color(0xfff1e1bb),
      tertiary: Color(0xffaccfaf),
      onTertiary: Color(0xff18371f),
      tertiaryContainer: Color(0xff2f4e34),
      onTertiaryContainer: Color(0xffc8ecca),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff16130b),
      onBackground: Color(0xffeae2d4),
      surface: Color(0xff16130b),
      onSurface: Color(0xffeae2d4),
      surfaceVariant: Color(0xff4c4639),
      onSurfaceVariant: Color(0xffcfc6b4),
      outline: Color(0xff989080),
      outlineVariant: Color(0xff4c4639),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeae2d4),
      inverseOnSurface: Color(0xff343027),
      inversePrimary: Color(0xff725c0c),
      primaryFixed: Color(0xffffe087),
      onPrimaryFixed: Color(0xff231a00),
      primaryFixedDim: Color(0xffe2c46d),
      onPrimaryFixedVariant: Color(0xff574500),
      secondaryFixed: Color(0xfff1e1bb),
      onSecondaryFixed: Color(0xff221b04),
      secondaryFixedDim: Color(0xffd4c5a1),
      onSecondaryFixedVariant: Color(0xff50462a),
      tertiaryFixed: Color(0xffc8ecca),
      onTertiaryFixed: Color(0xff03210c),
      tertiaryFixedDim: Color(0xffaccfaf),
      onTertiaryFixedVariant: Color(0xff2f4e34),
      surfaceDim: Color(0xff16130b),
      surfaceBright: Color(0xff3d392f),
      surfaceContainerLowest: Color(0xff110e07),
      surfaceContainerLow: Color(0xff1f1b13),
      surfaceContainer: Color(0xff231f17),
      surfaceContainerHigh: Color(0xff2d2a21),
      surfaceContainerHighest: Color(0xff38342b),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe6c870),
      surfaceTint: Color(0xffe2c46d),
      onPrimary: Color(0xff1d1500),
      primaryContainer: Color(0xffa88e3d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd9caa5),
      onSecondary: Color(0xff1d1501),
      secondaryContainer: Color(0xff9d906e),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb0d4b3),
      onTertiary: Color(0xff001b08),
      tertiaryContainer: Color(0xff78997b),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff16130b),
      onBackground: Color(0xffeae2d4),
      surface: Color(0xff16130b),
      onSurface: Color(0xfffffaf6),
      surfaceVariant: Color(0xff4c4639),
      onSurfaceVariant: Color(0xffd3cab8),
      outline: Color(0xffaaa291),
      outlineVariant: Color(0xff8a8273),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeae2d4),
      inverseOnSurface: Color(0xff2d2a21),
      inversePrimary: Color(0xff584600),
      primaryFixed: Color(0xffffe087),
      onPrimaryFixed: Color(0xff171000),
      primaryFixedDim: Color(0xffe2c46d),
      onPrimaryFixedVariant: Color(0xff433400),
      secondaryFixed: Color(0xfff1e1bb),
      onSecondaryFixed: Color(0xff171000),
      secondaryFixedDim: Color(0xffd4c5a1),
      onSecondaryFixedVariant: Color(0xff3e351b),
      tertiaryFixed: Color(0xffc8ecca),
      onTertiaryFixed: Color(0xff001505),
      tertiaryFixedDim: Color(0xffaccfaf),
      onTertiaryFixedVariant: Color(0xff1e3c25),
      surfaceDim: Color(0xff16130b),
      surfaceBright: Color(0xff3d392f),
      surfaceContainerLowest: Color(0xff110e07),
      surfaceContainerLow: Color(0xff1f1b13),
      surfaceContainer: Color(0xff231f17),
      surfaceContainerHigh: Color(0xff2d2a21),
      surfaceContainerHighest: Color(0xff38342b),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffffaf6),
      surfaceTint: Color(0xffe2c46d),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffe6c870),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd9caa5),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff0ffed),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb0d4b3),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff16130b),
      onBackground: Color(0xffeae2d4),
      surface: Color(0xff16130b),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff4c4639),
      onSurfaceVariant: Color(0xfffffaf6),
      outline: Color(0xffd3cab8),
      outlineVariant: Color(0xffd3cab8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeae2d4),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff352900),
      primaryFixed: Color(0xffffe59d),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffe6c870),
      onPrimaryFixedVariant: Color(0xff1d1500),
      secondaryFixed: Color(0xfff6e6bf),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd9caa5),
      onSecondaryFixedVariant: Color(0xff1d1501),
      tertiaryFixed: Color(0xffccf0ce),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb0d4b3),
      onTertiaryFixedVariant: Color(0xff001b08),
      surfaceDim: Color(0xff16130b),
      surfaceBright: Color(0xff3d392f),
      surfaceContainerLowest: Color(0xff110e07),
      surfaceContainerLow: Color(0xff1f1b13),
      surfaceContainer: Color(0xff231f17),
      surfaceContainerHigh: Color(0xff2d2a21),
      surfaceContainerHighest: Color(0xff38342b),
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
     scaffoldBackgroundColor: colorScheme.surface,
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
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
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
