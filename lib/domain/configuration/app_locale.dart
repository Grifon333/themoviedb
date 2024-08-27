import 'dart:ui';

import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocale {
  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('uk', 'UA'),
    Locale('ru', 'RU'),
  ];
}
