import 'package:crm/l10n/l10n.dart';

class LanguageSettings {
  static List<int> language = [
    0, // Английский
    1, // Немецкий
  ];

  static String translatePlace(AppLocalizations l10n, int number) {
    switch (number) {
      case 0:
        return l10n.lang1;
      case 1:
        return l10n.lang2;
      default:
        return '';
    }
  }
}
