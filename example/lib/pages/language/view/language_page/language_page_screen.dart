part of '../language_page.dart';

class LanguagePageScreen extends StatefulWidget {
  const LanguagePageScreen({
    super.key,
    required this.localeList,
    required this.storedLocale,
  });

  final Locale? storedLocale;
  final List<Locale> localeList;

  @override
  State<LanguagePageScreen> createState() => _LanguagePageScreenState();
}

class _LanguagePageScreenState extends State<LanguagePageScreen> {
  List<Locale?>? _locales;
  List<Locale?> get _list => _locales ??= [null, ...widget.localeList];

  Locale? _selected;

  @override
  void initState() {
    super.initState();

    _selected = widget.storedLocale;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'language_options'.tr(),
          ),
          titleTextStyle: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(top: 8),
                itemCount: _list.length,
                itemBuilder: (context, index) => ListTile(
                  trailing: Icon(
                    _selected == _list.elementAt(index)
                        ? widget.storedLocale == _list.elementAt(index)
                            ? Icons.check_circle_outlined
                            : Icons.check
                        : widget.storedLocale == _list.elementAt(index)
                            ? Icons.circle_outlined
                            : null,
                  ),
                  title: Text(
                    index == 0 ? 'system_language'.tr() : Localization.getNativeNameOf(_list.elementAt(index)!),
                  ),
                  onTap: () {
                    if (_list.elementAt(index) != _selected) {
                      _selected = _list.elementAt(index);
                      setState(() {});
                    }
                  },
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(9),
                child: FilledButton(
                  style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 54)),
                  child: Text(
                    'accept'.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (widget.storedLocale != _selected) {
                      await ((_selected == null) ? context.resetLocale() : context.setLocale(_selected!))
                          .then((value) => Navigator.pop(context));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
