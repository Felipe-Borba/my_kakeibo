import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4285684748),
      surfaceTint: Color(4285684748),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4294959239),
      onPrimaryContainer: Color(4280490496),
      secondary: Color(4285095231),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4294042043),
      onSecondaryContainer: Color(4280425220),
      tertiary: Color(4282803787),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4291357898),
      onTertiaryContainer: Color(4278395148),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294965488),
      onBackground: Color(4280228627),
      surface: Color(4294965488),
      onSurface: Color(4280228627),
      surfaceVariant: Color(4293648847),
      onSurfaceVariant: Color(4283188793),
      outline: Color(4286412391),
      outlineVariant: Color(4291806900),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281610279),
      inverseOnSurface: Color(4294504674),
      inversePrimary: Color(4293051501),
      primaryFixed: Color(4294959239),
      onPrimaryFixed: Color(4280490496),
      primaryFixedDim: Color(4293051501),
      onPrimaryFixedVariant: Color(4283909376),
      secondaryFixed: Color(4294042043),
      onSecondaryFixed: Color(4280425220),
      secondaryFixedDim: Color(4292134305),
      onSecondaryFixedVariant: Color(4283450922),
      tertiaryFixed: Color(4291357898),
      onTertiaryFixed: Color(4278395148),
      tertiaryFixedDim: Color(4289515439),
      onTertiaryFixedVariant: Color(4281290292),
      surfaceDim: Color(4292991436),
      surfaceBright: Color(4294965488),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294702053),
      surfaceContainer: Color(4294307295),
      surfaceContainerHigh: Color(4293912537),
      surfaceContainerHighest: Color(4293583572),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4283580672),
      surfaceTint: Color(4285684748),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4287263267),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4283187750),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4286608468),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281026865),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284251232),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294965488),
      onBackground: Color(4280228627),
      surface: Color(4294965488),
      onSurface: Color(4280228627),
      surfaceVariant: Color(4293648847),
      onSurfaceVariant: Color(4282925621),
      outline: Color(4284833360),
      outlineVariant: Color(4286675563),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281610279),
      inverseOnSurface: Color(4294504674),
      inversePrimary: Color(4293051501),
      primaryFixed: Color(4287263267),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4285487625),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4286608468),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4284898109),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284251232),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282671945),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292991436),
      surfaceBright: Color(4294965488),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294702053),
      surfaceContainer: Color(4294307295),
      surfaceContainerHigh: Color(4293912537),
      surfaceContainerHighest: Color(4293583572),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4281016576),
      surfaceTint: Color(4285684748),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283580672),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280885513),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283187750),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278790162),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4281026865),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294965488),
      onBackground: Color(4280228627),
      surface: Color(4294965488),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293648847),
      onSurfaceVariant: Color(4280820760),
      outline: Color(4282925621),
      outlineVariant: Color(4282925621),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281610279),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4294962102),
      primaryFixed: Color(4283580672),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281871104),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283187750),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281609234),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4281026865),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4279579420),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292991436),
      surfaceBright: Color(4294965488),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294702053),
      surfaceContainer: Color(4294307295),
      surfaceContainerHigh: Color(4293912537),
      surfaceContainerHighest: Color(4293583572),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4293051501),
      surfaceTint: Color(4293051501),
      onPrimary: Color(4282134272),
      primaryContainer: Color(4283909376),
      onPrimaryContainer: Color(4294959239),
      secondary: Color(4292134305),
      onSecondary: Color(4281872406),
      secondaryContainer: Color(4283450922),
      onSecondaryContainer: Color(4294042043),
      tertiary: Color(4289515439),
      onTertiary: Color(4279777055),
      tertiaryContainer: Color(4281290292),
      onTertiaryContainer: Color(4291357898),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279636747),
      onBackground: Color(4293583572),
      surface: Color(4279636747),
      onSurface: Color(4293583572),
      surfaceVariant: Color(4283188793),
      onSurfaceVariant: Color(4291806900),
      outline: Color(4288188544),
      outlineVariant: Color(4283188793),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293583572),
      inverseOnSurface: Color(4281610279),
      inversePrimary: Color(4285684748),
      primaryFixed: Color(4294959239),
      onPrimaryFixed: Color(4280490496),
      primaryFixedDim: Color(4293051501),
      onPrimaryFixedVariant: Color(4283909376),
      secondaryFixed: Color(4294042043),
      onSecondaryFixed: Color(4280425220),
      secondaryFixedDim: Color(4292134305),
      onSecondaryFixedVariant: Color(4283450922),
      tertiaryFixed: Color(4291357898),
      onTertiaryFixed: Color(4278395148),
      tertiaryFixedDim: Color(4289515439),
      onTertiaryFixedVariant: Color(4281290292),
      surfaceDim: Color(4279636747),
      surfaceBright: Color(4282202415),
      surfaceContainerLowest: Color(4279307783),
      surfaceContainerLow: Color(4280228627),
      surfaceContainer: Color(4280491799),
      surfaceContainerHigh: Color(4281149985),
      surfaceContainerHighest: Color(4281873451),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4293314672),
      surfaceTint: Color(4293051501),
      onPrimary: Color(4280096000),
      primaryContainer: Color(4289236541),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4292463269),
      onSecondary: Color(4280096001),
      secondaryContainer: Color(4288516206),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4289778867),
      onTertiary: Color(4278197000),
      tertiaryContainer: Color(4286093691),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279636747),
      onBackground: Color(4293583572),
      surface: Color(4279636747),
      onSurface: Color(4294966006),
      surfaceVariant: Color(4283188793),
      onSurfaceVariant: Color(4292070072),
      outline: Color(4289372817),
      outlineVariant: Color(4287267443),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293583572),
      inverseOnSurface: Color(4281149985),
      inversePrimary: Color(4283975168),
      primaryFixed: Color(4294959239),
      onPrimaryFixed: Color(4279701504),
      primaryFixedDim: Color(4293051501),
      onPrimaryFixedVariant: Color(4282594304),
      secondaryFixed: Color(4294042043),
      onSecondaryFixed: Color(4279701504),
      secondaryFixedDim: Color(4292134305),
      onSecondaryFixedVariant: Color(4282266907),
      tertiaryFixed: Color(4291357898),
      onTertiaryFixed: Color(4278195461),
      tertiaryFixedDim: Color(4289515439),
      onTertiaryFixedVariant: Color(4280171557),
      surfaceDim: Color(4279636747),
      surfaceBright: Color(4282202415),
      surfaceContainerLowest: Color(4279307783),
      surfaceContainerLow: Color(4280228627),
      surfaceContainer: Color(4280491799),
      surfaceContainerHigh: Color(4281149985),
      surfaceContainerHighest: Color(4281873451),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294966006),
      surfaceTint: Color(4293051501),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4293314672),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294966006),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4292463269),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293984237),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4289778867),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279636747),
      onBackground: Color(4293583572),
      surface: Color(4279636747),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4283188793),
      onSurfaceVariant: Color(4294966006),
      outline: Color(4292070072),
      outlineVariant: Color(4292070072),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293583572),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4281673984),
      primaryFixed: Color(4294960541),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4293314672),
      onPrimaryFixedVariant: Color(4280096000),
      secondaryFixed: Color(4294371007),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4292463269),
      onSecondaryFixedVariant: Color(4280096001),
      tertiaryFixed: Color(4291621070),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4289778867),
      onTertiaryFixedVariant: Color(4278197000),
      surfaceDim: Color(4279636747),
      surfaceBright: Color(4282202415),
      surfaceContainerLowest: Color(4279307783),
      surfaceContainerLow: Color(4280228627),
      surfaceContainer: Color(4280491799),
      surfaceContainerHigh: Color(4281149985),
      surfaceContainerHighest: Color(4281873451),
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
