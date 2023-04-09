import 'package:crm/l10n/l10n.dart';

class WorkplaceSettings {
  static List<int> places = [
    0, // Новосибирск
    1, // Крым
  ];

  static String translatePlace(AppLocalizations l10n, int number) {
    switch (number) {
      case 0:
        return l10n.city1;
      case 1:
        return l10n.city2;
      default:
        return '';
    }
  }
}
