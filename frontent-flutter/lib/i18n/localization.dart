import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locale_controller.dart';

class AppLocalization {
  final Locale locale;
  const AppLocalization(this.locale);

  Map? get _localizedStrings => LocaleAsset.localeAsset;

  Future<void> load() async {
    await LocaleAsset.getAsset(locale.languageCode);
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  String getString(String key) {
    return _localizedStrings?[key] ?? '';
  }

  String get greetings => getString('greetings');
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final BuildContext context;
  const AppLocalizationDelegate(this.context);

  @override
  bool isSupported(Locale locale) {
    return Provider.of<LocalePref>(context)
        .supportedLocales
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    final localizations = AppLocalization(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
