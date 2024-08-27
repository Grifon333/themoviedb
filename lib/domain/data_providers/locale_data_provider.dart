import 'package:shared_preferences/shared_preferences.dart';

class _Keys {
  static const localeTag = 'locale_tag';
  static const countryCode = 'country_code';
}

class LocaleDataProvider {
  final Future<SharedPreferences> _storage = SharedPreferences.getInstance();

  Future<void> setLocaleTag(String localeTag) async {
    (await _storage).setString(_Keys.localeTag, localeTag);
  }

  Future<void> setCountryCode(String countryCode) async {
    (await _storage).setString(_Keys.countryCode, countryCode);
  }

  Future<void> deleteLocale() async {
    (await _storage).remove('locale_tag');
    (await _storage).remove('country_code');
  }

  Future<String> get localeTag async {
    return (await _storage).getString(_Keys.localeTag) ?? '';
  }

  Future<String> get countryCode async {
    return (await _storage).getString(_Keys.countryCode) ?? '';
  }
}
