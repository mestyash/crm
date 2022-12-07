import 'package:crm/bootstrap.dart';
import 'package:crm/core/locator.dart';
import 'package:crm/features/common/app/view/app.dart';

void main() {
  initGetIt();
  bootstrap(() => const App());
}
