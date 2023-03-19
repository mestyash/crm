import 'package:crm/core/api/payments/payments_supabase.dart';
import 'package:crm/core/data/data_source/supabase_client/supabase_client.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final x = PaymentsSupabase(client: SupabaseClient());
    final z = CustomDateUtils.firstOrLastDateOfCurrentMonth();
    final z1 = CustomDateUtils.firstOrLastDateOfCurrentMonth(first: false);
    x.getPaymentsByRange(
        startDate: CustomDateUtils.prepareDateForBackend(z),
        endDate: CustomDateUtils.prepareDateForBackend(z1));
    print([z, z1]);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('payment'),
      ),
    );
  }
}
