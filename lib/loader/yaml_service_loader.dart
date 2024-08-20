import 'package:easy_localization_loader/easy_localization_loader.dart';

import '_asset_loader.dart';

class YamlServiceLoader extends ILocalizationLoader {
  YamlServiceLoader({
    required super.assetLocales,
    super.service,
  }) : super(
          fileType: 'yaml',
          assetLoader: const YamlAssetLoader(),
        );
}
