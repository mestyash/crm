import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/inputs/input_date/input_date.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/statistics/salary_statistics/domain/entity/salary_statistic_model.dart';
import 'package:crm/features/admin/statistics/salary_statistics/presentation/cubit/salary_statistics_cubit.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalaryStatisticsScreen extends StatelessWidget {
  final SalaryStatisticsCubit cubit;

  const SalaryStatisticsScreen({
    super.key,
    required this.cubit,
  });

  void _listener(
    BuildContext context,
    SalaryStatisticsState state,
  ) {
    final _l10n = context.l10n;
    if (state.isFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(text: _l10n.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: BlocConsumer<SalaryStatisticsCubit, SalaryStatisticsState>(
        listener: _listener,
        builder: (context, state) => _ScreenData(state: state),
      ),
    );
  }
}

class _ScreenData extends StatefulWidget {
  final SalaryStatisticsState state;

  const _ScreenData({required this.state});

  @override
  State<_ScreenData> createState() => _ScreenDataState();
}

class _ScreenDataState extends State<_ScreenData> {
  late SalaryStatisticsCubit cubit;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  @override
  void initState() {
    cubit = context.read<SalaryStatisticsCubit>();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    super.initState();
  }

  void onStartDateChange(DateTime date) {
    cubit.onStartDateChange(date);
    startDateController.text = CustomDateUtils.prepareDateForBackend(date);
  }

  void onEndDateChange(DateTime date) {
    cubit.onEndDateChange(date);
    endDateController.text = CustomDateUtils.prepareDateForBackend(date);
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: CustomAppBar(title: l10n.salaries),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: ProjectMargin.contentHorizontal,
          vertical: ProjectMargin.contentTop,
        ),
        children: [
          Row(
            children: [
              Expanded(
                child: InputDate(
                  hintText: l10n.from,
                  controller: startDateController,
                  showBottomMargin: false,
                  date: widget.state.startDate ?? DateTime.now(),
                  onChange: onStartDateChange,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: InputDate(
                  hintText: l10n.to,
                  controller: endDateController,
                  showBottomMargin: false,
                  date: widget.state.endDate ?? DateTime.now(),
                  onChange: onEndDateChange,
                ),
              ),
            ],
          ),
          SizedBox(height: 17.5.h),
          ...widget.state.isLoading
              ? List.generate(
                  16,
                  (i) => ShimmerContainer(
                    width: double.infinity,
                    height: 30.h,
                    margin: EdgeInsets.only(bottom: 15.h),
                  ),
                )
              : widget.state.statistics.map((e) => _Card(data: e))
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final SalaryStatisticModel data;

  const _Card({required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 7.5.r, vertical: 10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: ProjectShadow.boxShadow1,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.teacher.fullName1,
              style: textTheme.bodyLarge,
            ),
          ),
          SizedBox(width: 5.5.w),
          Text(data.salary.toString(), style: textTheme.titleSmall),
        ],
      ),
    );
  }
}
