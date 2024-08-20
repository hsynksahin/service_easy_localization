import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:service_easy_localization/easy_localization.dart';
import 'package:service_easy_localization/service/_localization_service.dart';

class FirebaseLocalizationService extends ILocalizationService {
  const FirebaseLocalizationService();

  static const folder = 'localizations';

  @override
  Future<Uint8List?> downloadLocale(Locale locale) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final fileRef = storageRef.child('$folder/$locale.yaml');

      var bytes = await fileRef.getData();

      return bytes;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<List<Locale>> getServiceList() async {
    try {
      var ref = FirebaseStorage.instance.ref();

      var list = await ref.child(folder).listAll();

      return list.items.map((e) => e.name.split('.').first.toLocale()).toList();
    } catch (error) {
      return [];
    }
  }
}
