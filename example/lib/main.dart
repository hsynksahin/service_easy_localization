import 'package:example/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:service_easy_localization/easy_localization.dart';
import 'package:service_easy_localization/env.dart';
import 'package:service_easy_localization/loader/yaml_service_loader.dart';
import 'package:service_easy_localization/localization.dart';
import 'package:service_easy_localization/logger.dart';
import 'dart:developer' as developer;

import 'firebase_options.dart';
import 'services/service_localization.dart';

Future<void> main() async {
  // ignore: unused_local_variable
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await (Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));

  EasyLogger logger = EasyLogger(
    name: '🌎 EasyLocalization',
    enableBuildModes: [BuildMode.debug, BuildMode.profile, BuildMode.release],
    enableLevels: [
      if (LocalizationEnvironment.log) LevelMessages.debug,
      if (LocalizationEnvironment.logInfo) LevelMessages.info,
      if (LocalizationEnvironment.logError) LevelMessages.warning,
      if (LocalizationEnvironment.logError) LevelMessages.error,
    ],
    printer: (object, {LevelMessages? level, name, stackTrace}) => switch (level) {
      _ => developer.log('[$name](${level.toString().split('.').last}) $object'),
    },
  );
  EasyLocalization.logger = logger;

  runApp(await Localization.initialize(
    app: const MyApp(),
    localizationLoader: YamlServiceLoader(
      service: const FirebaseLocalizationService(),
      assetLocales: [
        const Locale('en'),
        const Locale('tr'),
      ],
    ),
  ));
}
