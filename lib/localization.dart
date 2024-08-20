import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'env.dart';
import 'loader/_asset_loader.dart';

abstract class Localization {
  static const fallbackLanguageCode = LocalizationEnvironment.fallback;
  static const fallbackLocale = Locale(fallbackLanguageCode);

  // static Locale systemLocale(BuildContext context) =>
  //     (EasyLocalization.of(context)?.deviceLocale ??
  //         context.supportedLocales
  //             .where((element) => element.languageCode == Platform.localeName.substring(0, 2))
  //             .firstOrNull) ??
  //     context.supportedLocales.first;

  static String getNativeNameOf(Locale locale) {
    var nativeList = LocaleNamesLocalizationsDelegate.nativeLocaleNames;
    if (nativeList.containsKey(locale.languageCode)) {
      return nativeList[locale.languageCode]!;
    }

    return locale.languageCode;
  }

  static ui.TextDirection textDirection(BuildContext context) => Directionality.of(context);

  static Future<Locale?> get savedLocale async {
    final preferences = await SharedPreferences.getInstance();
    final strLocale = preferences.getString('locale');
    return strLocale?.toLocale();
  }

  static Future<Widget> initialize({
    required ILocalizationLoader localizationLoader,
    String assetPath = 'assets/localization',
    required Widget app,
  }) async {
    var supportedLocales = await localizationLoader.getSupportedList();
    var startLocale = await Localization.savedLocale;

    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.info(
      '[🌎 EasyLocalization] Initialized\n'
      'Start locale: ($startLocale)\n'
      'Supported locales: [${supportedLocales.map((e) => e.toString()).join(', ')}]',
    );

    // TODO: Bring some customizations to params
    return EasyLocalization(
      path: assetPath,
      // startLocale: startLocale, // ? May not need it
      fallbackLocale: Localization.fallbackLocale,
      useFallbackTranslations: true,
      useFallbackTranslationsForEmptyResources: true,
      useOnlyLangCode: true,
      supportedLocales: supportedLocales,
      assetLoader: localizationLoader,
      errorWidget: kDebugMode ? null : (message) => const SizedBox(),
      child: app,
    );
  }
}

extension BuildContextExtensions on BuildContext {
  bool isSupported(Locale locale) => supportedLocales.any((element) => element.languageCode == locale.languageCode);
}
