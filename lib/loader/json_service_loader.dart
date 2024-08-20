import '../loaders.dart';
import '_asset_loader.dart';

// TODO (test): Did not tested if its gonna work

class JsonServiceLoader extends ILocalizationLoader {
  JsonServiceLoader({
    required super.assetLocales,
    super.service,
  }) : super(
          fileType: 'json',
          assetLoader: const JsonAssetLoader(),
        );
}
