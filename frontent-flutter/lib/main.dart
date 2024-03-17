import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'i18n/locale_controller.dart';
import 'i18n/localization.dart';
import 'view/home_page.dart';

Future<void> main() async {
  await LocalePref.initialize();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocalePref()..getSupportedLocales(),
      builder: (context, _) {
        final localeProvider = Provider.of<LocalePref>(context);

        return MaterialApp(
          localizationsDelegates: [
            AppLocalizationDelegate(context),
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales:
              localeProvider.supportedLocales.map((id) => Locale(id)),
          locale: localeProvider.currentLocale,
          home: const HomePage(),
        );
      },
    );
  }
}
