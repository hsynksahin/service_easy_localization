# Getting Started

Run `flutter pub get` first as to initialize the packages.

Open a firebase project for yourself and initialize a Storage on it.

All Firebase initialization files are .gitignored so,
you need to execute `firebase login` from the firebase CLI tool,
then execute `flutterfire configure` to add your firebase configurations.

Upload the yaml files from `assets/localization/service` directory to your firebase storage under `localizations` folder.
These files are not included to the project by default. So asset loaders can not load it. But in the end, It should load it from your service.

This project is waiting your impressions and improvements.
Please notify any issues.
