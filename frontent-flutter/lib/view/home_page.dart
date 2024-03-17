import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../i18n/locale_controller.dart';
import '../i18n/localization.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<LocalePref>(
              builder: (BuildContext context, LocalePref value, _) {
                return PopupMenuButton(
                  elevation: 4,
                  onSelected: (e) {
                    Provider.of<LocalePref>(
                      context,
                      listen: false,
                    ).switchLocale(e);
                  },
                  itemBuilder: (context) {
                    return value.supportedLocales
                        .map(
                          (e) => PopupMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(value.currentLocale.languageCode),
                      const SizedBox(width: 8),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            Text(
              appLocalizationGetter(context).getString('greetings'),
            )
          ],
        ),
      ),
    );
  }
}
