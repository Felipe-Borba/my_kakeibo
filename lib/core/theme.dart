import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4284768533),
      surfaceTint: Color(4284768533),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4293715597),
      onPrimaryContainer: Color(4280163328),
      secondary: Color(4284636994),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4293452990),
      onSecondaryContainer: Color(4280163333),
      tertiary: Color(4282345045),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4290899158),
      onTertiaryContainer: Color(4278198549),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294900203),
      onSurface: Color(4280097812),
      onSurfaceVariant: Color(4282992442),
      outline: Color(4286216040),
      outlineVariant: Color(4291479477),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281479464),
      inversePrimary: Color(4291807860),
      primaryFixed: Color(4293715597),
      onPrimaryFixed: Color(4280163328),
      primaryFixedDim: Color(4291807860),
      onPrimaryFixedVariant: Color(4283189504),
      secondaryFixed: Color(4293452990),
      onSecondaryFixed: Color(4280163333),
      secondaryFixedDim: Color(4291610788),
      onSecondaryFixedVariant: Color(4283058220),
      tertiaryFixed: Color(4290899158),
      onTertiaryFixed: Color(4278198549),
      tertiaryFixedDim: Color(4289056954),
      onTertiaryFixedVariant: Color(4280766014),
      surfaceDim: Color(4292795085),
      surfaceBright: Color(4294900203),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294505446),
      surfaceContainer: Color(4294110944),
      surfaceContainerHigh: Color(4293716187),
      surfaceContainerHighest: Color(4293321429),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282926080),
      surfaceTint: Color(4284768533),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4286281515),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282795048),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4286084694),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280437306),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283792746),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294900203),
      onSurface: Color(4280097812),
      onSurfaceVariant: Color(4282729270),
      outline: Color(4284571473),
      outlineVariant: Color(4286479212),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281479464),
      inversePrimary: Color(4291807860),
      primaryFixed: Color(4286281515),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4284636691),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4286084694),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4284439872),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283792746),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282147922),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292795085),
      surfaceBright: Color(4294900203),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294505446),
      surfaceContainer: Color(4294110944),
      surfaceContainerHigh: Color(4293716187),
      surfaceContainerHighest: Color(4293321429),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4280623872),
      surfaceTint: Color(4284768533),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282926080),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280558347),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282795048),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200347),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4280437306),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294900203),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280624153),
      outline: Color(4282729270),
      outlineVariant: Color(4282729270),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281479464),
      inversePrimary: Color(4294373525),
      primaryFixed: Color(4282926080),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281347584),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282795048),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281282068),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4280437306),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278727460),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292795085),
      surfaceBright: Color(4294900203),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294505446),
      surfaceContainer: Color(4294110944),
      surfaceContainerHigh: Color(4293716187),
      surfaceContainerHighest: Color(4293321429),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4291807860),
      surfaceTint: Color(4291807860),
      onPrimary: Color(4281610752),
      primaryContainer: Color(4283189504),
      onPrimaryContainer: Color(4293715597),
      secondary: Color(4291610788),
      onSecondary: Color(4281544984),
      secondaryContainer: Color(4283058220),
      onSecondaryContainer: Color(4293452990),
      tertiary: Color(4289056954),
      onTertiary: Color(4279056168),
      tertiaryContainer: Color(4280766014),
      onTertiaryContainer: Color(4290899158),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279505932),
      onSurface: Color(4293321429),
      onSurfaceVariant: Color(4291479477),
      outline: Color(4287926657),
      outlineVariant: Color(4282992442),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321429),
      inversePrimary: Color(4284768533),
      primaryFixed: Color(4293715597),
      onPrimaryFixed: Color(4280163328),
      primaryFixedDim: Color(4291807860),
      onPrimaryFixedVariant: Color(4283189504),
      secondaryFixed: Color(4293452990),
      onSecondaryFixed: Color(4280163333),
      secondaryFixedDim: Color(4291610788),
      onSecondaryFixedVariant: Color(4283058220),
      tertiaryFixed: Color(4290899158),
      onTertiaryFixed: Color(4278198549),
      tertiaryFixedDim: Color(4289056954),
      onTertiaryFixedVariant: Color(4280766014),
      surfaceDim: Color(4279505932),
      surfaceBright: Color(4282071344),
      surfaceContainerLowest: Color(4279176711),
      surfaceContainerLow: Color(4280097812),
      surfaceContainer: Color(4280360984),
      surfaceContainerHigh: Color(4281018913),
      surfaceContainerHighest: Color(4281742636),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4292136568),
      surfaceTint: Color(4291807860),
      onPrimary: Color(4279768832),
      primaryContainer: Color(4288189252),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4291873960),
      onSecondary: Color(4279768834),
      secondaryContainer: Color(4287992433),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4289320126),
      onTertiary: Color(4278197009),
      tertiaryContainer: Color(4285569414),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279505932),
      onSurface: Color(4294966254),
      onSurfaceVariant: Color(4291808185),
      outline: Color(4289110931),
      outlineVariant: Color(4287005556),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321429),
      inversePrimary: Color(4283255296),
      primaryFixed: Color(4293715597),
      onPrimaryFixed: Color(4279439872),
      primaryFixedDim: Color(4291807860),
      onPrimaryFixedVariant: Color(4282005504),
      secondaryFixed: Color(4293452990),
      onSecondaryFixed: Color(4279439873),
      secondaryFixedDim: Color(4291610788),
      onSecondaryFixedVariant: Color(4281939741),
      tertiaryFixed: Color(4290899158),
      onTertiaryFixed: Color(4278195468),
      tertiaryFixedDim: Color(4289056954),
      onTertiaryFixedVariant: Color(4279516462),
      surfaceDim: Color(4279505932),
      surfaceBright: Color(4282071344),
      surfaceContainerLowest: Color(4279176711),
      surfaceContainerLow: Color(4280097812),
      surfaceContainer: Color(4280360984),
      surfaceContainerHigh: Color(4281018913),
      surfaceContainerHighest: Color(4281742636),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294966254),
      surfaceTint: Color(4291807860),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4292136568),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294966254),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291873960),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293787636),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4289320126),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279505932),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294966254),
      outline: Color(4291808185),
      outlineVariant: Color(4291808185),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321429),
      inversePrimary: Color(4281150208),
      primaryFixed: Color(4294044305),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4292136568),
      onPrimaryFixedVariant: Color(4279768832),
      secondaryFixed: Color(4293781698),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291873960),
      onSecondaryFixedVariant: Color(4279768834),
      tertiaryFixed: Color(4291162586),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4289320126),
      onTertiaryFixedVariant: Color(4278197009),
      surfaceDim: Color(4279505932),
      surfaceBright: Color(4282071344),
      surfaceContainerLowest: Color(4279176711),
      surfaceContainerLow: Color(4280097812),
      surfaceContainer: Color(4280360984),
      surfaceContainerHigh: Color(4281018913),
      surfaceContainerHighest: Color(4281742636),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
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
