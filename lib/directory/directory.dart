// Copyright (c) 2024. All rights reserved.
//
// @author: Hüseyin Küçükşahin
// @date: 17.05.2024

/// **Version:** 1.0.0
///
/// Directory Utilities
///
library directory;

import 'dart:io' show Directory, Platform;

import 'package:path_provider/path_provider.dart'
    show
        getApplicationDocumentsDirectory,
        getApplicationSupportDirectory,
        getExternalStorageDirectory,
        getLibraryDirectory;

class Directories {
  /// Returns a directory to save the files
  ///
  /// If [secure] the directory will be invisible from the user.
  ///
  static Future<Directory> get({bool secure = true}) async => await (secure ? library : documents);

  /// Returns [documents] directory which is accessible by the user.
  ///
  /// Use it for user-generated, non-protected files.
  ///
  /// In case of android can't cant reach to the external storage
  /// will return documents directory which is non-accessible on android.
  ///
  static Future<Directory> get documents async => Platform.isAndroid
      ? (await external) ?? await getApplicationDocumentsDirectory()
      : await getApplicationDocumentsDirectory();

  /// Returns [library] directory which is non-accessible by the user.
  ///
  /// Use it when the file should be secure-stored.
  ///
  static Future<Directory> get library async =>
      await ((Platform.isIOS || Platform.isMacOS) ? getLibraryDirectory() : getApplicationSupportDirectory());

  /// Returns The [external] storage directory for the app. accessible by the user.
  ///
  /// !!! Not supported by anything other than Android.
  ///
  static Future<Directory?> get external async => await getExternalStorageDirectory();
}
