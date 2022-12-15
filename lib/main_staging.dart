import 'package:crm/bootstrap.dart';
import 'package:crm/core/locator.dart';
import 'package:crm/features/common/app/view/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  initGetIt();
  bootstrap(() => sl.get<App>());
}
