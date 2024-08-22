import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class _Keys {
  static const localeTag = 'locale_tag';
  static const countryCode = 'country_code';
}

class LocaleDataProvider {
  final Future<SharedPreferences> _storage = SharedPreferences.getInstance();

  Future<void> setLocale(Locale locale) async {
    final storage = await _storage;
    final localeTag = locale.toLanguageTag();
    final countryCode = locale.countryCode ?? 'US';
    storage.setString(_Keys.localeTag, localeTag);
    storage.setString(_Keys.countryCode, countryCode);
  }

  Future<String> get localeTag async {
    return (await _storage).getString(_Keys.localeTag) ?? '';
  }

  Future<String> get countryCode async {
    return (await _storage).getString(_Keys.countryCode) ?? '';
  }
}
