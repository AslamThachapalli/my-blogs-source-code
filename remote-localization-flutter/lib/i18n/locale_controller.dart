import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locale_datasource.dart';

class LocalePref extends ChangeNotifier {
  static late final SharedPreferences pref;

  static Future<void> initialize() async {
    pref = await SharedPreferences.getInstance();
  }

  String _localeId = 'en';
  List<String> supportedLocales = ['en'];

  Locale get currentLocale {
    _localeId = pref.getString('locale') ?? 'en';
    return Locale(_localeId);
  }

  Future<void> getSupportedLocales() async {
    final data = await LocaleDatasource.getSupportedLocales();
    if (data != null) {
      supportedLocales = data;
      notifyListeners();
    }
  }

  void switchLocale(String newLocaleId) {
    pref.setString('locale', newLocaleId);
    _localeId = newLocaleId;
    notifyListeners();
  }
}

class LocaleAsset {
  static final LocaleAsset _instance = LocaleAsset._internal();

  LocaleAsset._internal();

  factory LocaleAsset() {
    return _instance;
  }

  static Map<String, dynamic>? localeAsset;

  static Future<void> getAsset(String localeId) async {
    final data = await LocaleDatasource.getLocaleData(localeId);
    localeAsset = data;
  }
}
