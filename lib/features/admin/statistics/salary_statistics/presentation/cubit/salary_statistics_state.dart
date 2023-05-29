part of 'salary_statistics_cubit.dart';

class SalaryStatisticsState extends Equatable {
  const SalaryStatisticsState({
    this.isLoading = false,
    this.isFailure = false,
    // ----
    this.startDate,
    this.endDate,
    this.statistics = const [],
  });

  final bool isLoading;
  final bool isFailure;
  // ----
  final DateTime? startDate;
  final DateTime? endDate;
  final List<SalaryStatisticModel> statistics;

  bool get canSearch => startDate != null && endDate != null;

  SalaryStatisticsState copyWith({
    bool? isLoading,
    bool? isFailure,
    // ----
    DateTime? startDate,
    DateTime? endDate,
    List<SalaryStatisticModel>? statistics,
  }) =>
      SalaryStatisticsState(
        isLoading: isLoading ?? this.isLoading,
        isFailure: isFailure ?? false,
        // ----
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        statistics: statistics ?? this.statistics,
      );

  @override
  List<Object?> get props => [
        isLoading,
        isFailure,
        // ----
        startDate,
        endDate,
        statistics,
      ];
}
