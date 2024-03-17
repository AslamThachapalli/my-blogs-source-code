import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'locale_controller.dart';

AppLocalization appLocalizationGetter(BuildContext context) =>
    Localizations.of<AppLocalization>(context, AppLocalization)!;

class AppLocalization {
  final BuildContext context;
  const AppLocalization(this.context);

  Map? get _localizedStrings => LocaleAsset.localeAsset;

  Future<void> load() async {
    final String localeId =
        Provider.of<LocalePref>(context).currentLocale.languageCode;
    await LocaleAsset.getAsset(localeId);
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
    final localizations = AppLocalization(context);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
