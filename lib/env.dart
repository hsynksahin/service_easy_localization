class LocalizationEnvironment {
  /// Use `mLocalizationLog` in dart defines to set this. (default: false)
  ///
  /// Enables logging inside of the module. It only covers the module logging.
  /// It will also enable debug logging for EasyLocalization package
  static const log = bool.fromEnvironment('mLocalizationLog', defaultValue: false);

  /// Use `mLocalizationLogInfo` in dart defines to set this. (default: true)
  ///
  /// Enables logging inside EasyLocalization package.
  static const logInfo = bool.fromEnvironment('mLocalizationLogInfo', defaultValue: true);

  /// Use `mLocalizationLogError` in dart defines to set this. (default: true)
  ///
  /// Enables ERROR logging inside EasyLocalization package.
  static const logError = bool.fromEnvironment('mLocalizationLogError', defaultValue: true);

  /// Use `mLocalizationFallback` in dart defines to set this. (default: 'en')
  ///
  /// Changes the storage key of this module. Module will not save data encrypted. No need to secure it.
  static const fallback = String.fromEnvironment('mLocalizationFallback', defaultValue: 'en');

  /// Use `mLocalizationSaveFilesHidden` in dart defines to set this. (default: true)
  ///
  /// Changes the downloaded localization files' visibility to the user. Set false only for debugging reasons.
  static const saveHidden = bool.fromEnvironment('mLocalizationSaveFilesHidden', defaultValue: true);

  /// Use `mLocalizationSaveFilesFolder` in dart defines to set this. (default: 'localizations')
  ///
  /// Changes the downloaded localization files' folder name.
  static const saveFolder = String.fromEnvironment('mLocalizationSaveFilesFolder', defaultValue: 'localizations');

  /// Use `mLocalizationFileUpdateInterval` in dart defines to set this. (default: 7)
  ///
  /// The saved localization files will be updated trough service every [saveInterval] days.
  ///
  /// It is gonna ignore the saved file all the time if set to `0`
  static const saveInterval = int.fromEnvironment('mLocalizationFileUpdateInterval', defaultValue: 7);
}
