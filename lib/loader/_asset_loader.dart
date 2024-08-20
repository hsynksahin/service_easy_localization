import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:yaml/yaml.dart';

import '../directory/directory.dart';
import '../env.dart';
import '../service/_localization_service.dart';

abstract class ILocalizationLoader extends AssetLoader {
  ILocalizationLoader({
    required this.assetLocales,
    this.service,
    required this.fileType,
    required this.assetLoader,
  });

  final AssetLoader assetLoader;

  /// A custom service needs to be made to use this function.
  ///
  /// If a service  is given
  final ILocalizationService? service;
  final List<Locale> assetLocales;

  final String fileType;

  Directory? _dir;
  Future<String> get getFolder async =>
      '${(_dir ??= await Directories.get(secure: LocalizationEnvironment.saveHidden)).path}/${LocalizationEnvironment.saveFolder}';
  String getFileName(Locale locale) => '${locale.toString()}.$fileType';

  Future<List<Locale>> getSupportedList() async {
    var localeList = assetLocales.toList();

    // ? Check already downloaded list
    var dir = Directory(await getFolder);
    if (await dir.exists()) {
      var list = dir.listSync();

      var locales = list.map((e) => e.uri.path.split('/').last.split('.').first);

      EasyLocalization.logger.debug('Detected downloaded locales: [${locales.join(', ')}]');

      localeList.addAll(locales.map((e) => e.toLocale()));
    }

    // ? Check service list
    if (service != null) {
      var serviceList = await service!.list;

      EasyLocalization.logger.debug('Detected service locales: [${serviceList.map((e) => e.toString()).join(', ')}]');

      // ? Add only the non existing ones
      localeList.addAll(serviceList
          .where((element) => !localeList.any((listElement) => element.toString() == listElement.toString())));
    }

    return localeList;
  }

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    // ? Load locale from assets if it is on assets.
    if (assetLocales.any((element) => element.toString() == locale.toString())) {
      if (service != null &&
          ILocalizationService.serviceLocales.any((element) => element.toString() == locale.toString())) {
        EasyLocalization.logger.debug('Service also has the $locale from assets. It is gonna be downloaded.');
      } else {
        EasyLocalization.logger.debug('Loading $locale from assets');
        return await assetLoader.load(path, locale);
      }
    }

    // ? If no service provided, locale can not be loaded
    if (service == null) {
      EasyLocalization.logger.warning('Selected locale not found.');
      return null;
    }

    var file = File('${await getFolder}/${getFileName(locale)}');
    try {
      var exists = await file.exists();

      // ? Checking is file save date passed interval days
      var shouldDownload = false;
      if (exists) {
        var now = DateTime.now();
        var lastDownload = await file.lastModified();
        if (now.difference(lastDownload).inDays >= LocalizationEnvironment.saveInterval) {
          EasyLocalization.logger.info('Downloaded locale `$locale` will be updated');
          shouldDownload = true;
        }
      }

      // ? If file exists then it is downloaded already.
      if (shouldDownload || !exists) {
        EasyLocalization.logger.debug('Loading $locale from service');
        var bytes = await service!.downloadLocale(locale);
        if (bytes == null) return null;

        await file.create(recursive: true);

        await file.writeAsBytes(bytes);
      } else {
        EasyLocalization.logger.debug('Loading $locale from downloaded files');
      }

      var yamlString = await file.readAsString();

      var yaml = loadYaml(yamlString);
      return Map<String, String>.from(yaml);
    } catch (error, trace) {
      EasyLocalization.logger.error('Failed to download/load the localization', stackTrace: trace);

      if (await file.exists()) {
        await file.delete();
      }

      return null;
    }
  }
}
