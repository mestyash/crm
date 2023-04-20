import 'package:crm/l10n/l10n.dart';

class LanguageSettings {
  static List<int> languages = [
    0, // Английский
    1, // Немецкий
  ];

  static String translateLanguage(AppLocalizations l10n, int number) {
    switch (number) {
      case 0:
        return l10n.lang1;
      case 1:
        return l10n.lang2;
      default:
        return '';
    }
  }

  static List<String> stringLanguages(AppLocalizations l10n) {
    return [
      l10n.lang1,
      l10n.lang2,
    ];
  }
}
