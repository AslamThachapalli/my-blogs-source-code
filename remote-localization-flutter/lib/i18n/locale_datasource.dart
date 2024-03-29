import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class LocaleDatasource {
  static String baseUrl =
      'https://backend.aslam-develop912.workers.dev/localize';

  static Future<List<String>?> getSupportedLocales() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/supported-locales'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;

        return (json['data'] as List<dynamic>).cast<String>();
      } else {
        return null;
      }

      // If the backend is down for some reason feel free to comment out the
      // above http calls and un-comment the below codes.

      // final response =
      //     await rootBundle.loadString('assets/supported_locale.json');

      // final json = jsonDecode(response) as Map<String, dynamic>;
      // return (json['data'] as List<dynamic>).cast<String>();
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getLocaleData(String localeId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$localeId'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;

        return json['data'];
      } else {
        return null;
      }

      // If the backend is down for some reason feel free to comment out the
      // above http calls and un-comment the below codes.

      // final response =
      //     await rootBundle.loadString('assets/i18n_$localeId.json');

      // final json = jsonDecode(response) as Map<String, dynamic>;
      // return json['data'];
    } catch (e) {
      return null;
    }
  }
}
