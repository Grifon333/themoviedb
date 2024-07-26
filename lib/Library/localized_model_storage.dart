import 'package:flutter/material.dart';

class LocalizedModelStorage {
  String _localeTag = '';
  String _countryCode = '';
  String get localeTag => _localeTag;
  String get countryCode => _countryCode;

  bool updateLocate(Locale locale) {
    final localeTag = locale.toLanguageTag();
    final countryCode = locale.countryCode ?? 'US';
    if (_localeTag == localeTag || _countryCode == countryCode) return false;
    _localeTag = localeTag;
    _countryCode = countryCode;
    return true;
  }
}