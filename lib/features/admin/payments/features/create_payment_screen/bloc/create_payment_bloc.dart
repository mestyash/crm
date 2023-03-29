import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm/core/domain/entity/user_model.dart';
import 'package:crm/features/admin/payments/core/data/repository/payments_repository.dart';
import 'package:equatable/equatable.dart';

part 'create_payment_event.dart';
part 'create_payment_state.dart';

class CreatePaymentBloc extends Bloc<CreatePaymentEvent, CreatePaymentState> {
  final PaymentsRepository _repository;

  CreatePaymentBloc({required PaymentsRepository repository})
      : _repository = repository,
        super(CreatePaymentState()) {
    on<CreatePaymentEventSearchStudents>(
      _onSearchStudents,
      transformer: restartable(),
    );
    on<CreatePaymentEventStudent>(_onStudentChange);
    on<CreatePaymentEventSum>(_onSumChange);
    on<CreatePaymentEventDate>(_onDateChange);
    on<CreatePaymentEventUpload>(_onUpload);
  }

  Future<void> _onSearchStudents(
    CreatePaymentEventSearchStudents event,
    Emitter<CreatePaymentState> emit,
  ) async {
    try {
      emit(state.copyWith(isSearching: true));
      final students = await _repository.searchStudents(surname: event.surname);
      emit(state.copyWith(isSearching: false, students: students));
    } catch (e) {
      emit(state.copyWith(isSearching: false, isFailure: true));
    }
  }

  void _onStudentChange(
    CreatePaymentEventStudent event,
    Emitter<CreatePaymentState> emit,
  ) {
    emit(state.copyWith(student: event.student));
  }

  void _onSumChange(
    CreatePaymentEventSum event,
    Emitter<CreatePaymentState> emit,
  ) {
    try {
      final sum = double.parse(event.sum);
      emit(state.copyWith(sum: sum, textFailure: false));
    } catch (e) {
      emit(state.copyWith(textFailure: true));
    }
  }

  void _onDateChange(
    CreatePaymentEventDate event,
    Emitter<CreatePaymentState> emit,
  ) {
    emit(state.copyWith(date: event.date));
  }

  Future<void> _onUpload(
    CreatePaymentEventUpload event,
    Emitter<CreatePaymentState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      emit(state.copyWith(successfullyCreated: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
    }
  }
}
