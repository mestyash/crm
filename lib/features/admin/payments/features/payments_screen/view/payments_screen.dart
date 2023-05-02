import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/admin/payments/features/payments_screen/bloc/payments_bloc.dart';
import 'package:crm/features/admin/payments/features/payments_screen/view/widgets/card/payments_card.dart';
import 'package:crm/features/admin/payments/features/payments_screen/view/widgets/filter/payments_filter.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  void _listener(
    BuildContext context,
    PaymentsState state,
  ) {
    final _l10n = context.l10n;
    if (state.isUploading) {
      context.loaderOverlay.show();
    }
    if (!state.isUploading) {
      context.loaderOverlay.hide();
    }
    if (state.isFailure) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(text: _l10n.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentsBloc, PaymentsState>(
      listener: _listener,
      builder: (context, state) => _ScreenData(
        state: state,
      ),
    );
  }
}

class _ScreenData extends StatelessWidget {
  final PaymentsState state;

  const _ScreenData({required this.state});

  Future<void> _link(BuildContext context) async {
    final data = await Navigator.pushNamed(context, Routes.createPayment);
    if (data != null) {
      context.read<PaymentsBloc>().add(PaymentsEventSearch());
    }
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final _padding = EdgeInsets.symmetric(
      horizontal: ProjectMargin.contentHorizontal,
      // vertical: ProjectMargin.contentTop,
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: _l10n.mainAdminNavBarPayments,
      ),
      floatingActionButton: CustomFloatingActionButton(
        action: () => _link(context),
      ),
      body: Column(
        children: [
          PaymentsFilter(
            startDate: state.startDate,
            endDate: state.endDate,
            mode: state.mode,
            student: state.student,
          ),
          Expanded(
            child: state.isLoading
                ? ListView.builder(
                    padding: _padding,
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, i) => ShimmerContainer(
                      width: double.infinity,
                      height: 125.h,
                      margin: EdgeInsets.only(bottom: 15.h),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: _padding,
                    itemCount: state.payments.length,
                    itemBuilder: (context, i) => PaymentsCard(
                      payment: state.payments[i],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
