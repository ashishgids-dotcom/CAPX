import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_strings.dart';

const String _kLanguageKey = 'selected_language_code';
const String _kHasOnboardedKey = 'has_completed_language_selection';

class LanguageProvider extends ChangeNotifier {
  final SharedPreferences _prefs;

  AppLanguage _language = AppLanguage.english;
  bool _hasOnboarded = false;

  LanguageProvider(this._prefs) {
    _load();
  }

  AppLanguage get language => _language;
  bool get hasOnboarded => _hasOnboarded;

  void _load() {
    final code = _prefs.getString(_kLanguageKey);
    if (code != null) {
      _language = AppLanguageX.fromCode(code);
    }
    _hasOnboarded = _prefs.getBool(_kHasOnboardedKey) ?? false;
  }

  Future<void> setLanguage(AppLanguage lang, {bool markOnboarded = true}) async {
    _language = lang;
    await _prefs.setString(_kLanguageKey, lang.code);
    if (markOnboarded) {
      _hasOnboarded = true;
      await _prefs.setBool(_kHasOnboardedKey, true);
    }
    notifyListeners();
  }
}
