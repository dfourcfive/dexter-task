import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class LocaleStrings extends Translations {
  Map<String, String>? enKeys;
  static const defaultLocale = Locale('en', 'US');
  static const fallBackLocal = Locale('en', 'US');
  Future<LocaleStrings> init() async {
    enKeys = await getENkeys();
    return this;
  }

  Future<Map<String, String>> getENkeys() async {
    return Map<String, String>.from(json.decode(await rootBundle.loadString('assets/flutter_i18n/en.json')));
  }

  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_US': enKeys!,
    };
  }

  static List<Locale> localeList = [
    const Locale('en', 'US'),
  ];
}
