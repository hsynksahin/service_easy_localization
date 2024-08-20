import 'package:flutter/material.dart';
import 'package:service_easy_localization/exports/easy_localization.dart';
import 'package:service_easy_localization/localization.dart';

part 'language_page/language_page_screen.dart';

class LanguagePage extends StatelessWidget {
  ///
  /// Pushes the page to the given context if [canPush].
  ///
  static Future<T?> push<T extends Object?>(BuildContext context) async => canPush(context).then(
        (list) async => list.length <= 1
            ? null
            : Localization.savedLocale.then(
                (locale) => Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (context) => LanguagePage(list: list, storedLocale: locale)),
                ),
              ),
      );

  ///
  /// Contains the navigation rules of the page and the starting procedure of the page.
  ///
  /// Returns if the page can be pushed.
  ///
  static Future<List<Locale>> canPush(BuildContext context) async {
    // ? Might want to refresh it here...
    var list = context.supportedLocales;

    return list;
  }
  // #endregion

  const LanguagePage({
    super.key,
    required this.list,
    required this.storedLocale,
  });

  /// The locale saved in the storage, not the currently used one
  final Locale? storedLocale;

  /// The list of all supported locales.
  final List<Locale> list;

  @override
  Widget build(BuildContext context) => LanguagePageScreen(
        storedLocale: storedLocale,
        localeList: list,
      );
}
