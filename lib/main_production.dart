import 'package:crm/bootstrap.dart';
import 'package:crm/core/locator.dart';
import 'package:crm/features/common/app/view/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  initGetIt();
  bootstrap(() => sl.get<App>());
}
