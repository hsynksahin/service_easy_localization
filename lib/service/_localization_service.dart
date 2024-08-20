import 'dart:ui';

import 'package:flutter/foundation.dart';

abstract class ILocalizationService {
  static List<Locale> serviceLocales = [];

  const ILocalizationService();

  Future<List<Locale>> get list async {
    serviceLocales = await getServiceList();
    return serviceLocales;
  }

  ///
  /// Make a function that returns locale list of all localization files existing on service.
  ///
  /// The ones that downloaded already should not be filtered
  ///
  /// ! This function need to be working lightning fast
  @protected
  Future<List<Locale>> getServiceList();

  ///
  /// Make a function that returns data (Uint8List) of downloaded file.
  ///
  Future<Uint8List?> downloadLocale(Locale locale);
}
