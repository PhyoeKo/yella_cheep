import 'dart:ui';

import 'package:explore_places/get_x/constant/translation/languages/th.dart';

import 'languages/ch.dart';
import 'languages/en.dart';


const translationNameKey = "name";
const translationLocaleKey = "locale";

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "zh_CH": chLanguage,
    "en_US": enLanguage,
    "th_TH": thLanguage,
  };

  static List<Map<String, dynamic>> locales = [
    {
      translationNameKey: 'Chinese',
      translationLocaleKey: const Locale('zh', 'CH'),
    },
    {
      translationNameKey: 'English',
      translationLocaleKey: const Locale('en', 'US'),
    },
    {
      translationNameKey: 'Thailand',
      translationLocaleKey: const Locale('th', 'TH'),
    },
  ];
}
