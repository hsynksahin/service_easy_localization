import '../loaders.dart';
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
