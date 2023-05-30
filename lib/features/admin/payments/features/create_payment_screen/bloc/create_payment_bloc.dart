import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/features/admin/payments/core/domain/payments_usecase.dart';
import 'package:equatable/equatable.dart';

part 'create_payment_event.dart';
part 'create_payment_state.dart';

class CreatePaymentBloc extends Bloc<CreatePaymentEvent, CreatePaymentState> {
  final IPaymentsRepository _repository;

  CreatePaymentBloc({required IPaymentsRepository repository})
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
      if (event.surname.length > 1) {
        emit(state.copyWith(isSearching: true));
        await Future.delayed(Duration(seconds: 1));
        final students =
            await _repository.searchStudents(surname: event.surname);
        emit(state.copyWith(isSearching: false, students: students));
      } else {
        emit(state.copyWith(isSearching: false, students: []));
      }
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
      final stringSum = event.sum;
      if (stringSum.isNotEmpty) {
        final sum = double.parse(event.sum);
        emit(state.copyWith(sum: sum, textFailure: false));
      } else {
        emit(state.copyWith(sum: 0, textFailure: false));
      }
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
      await _repository.uploadPayment(UploadPaymentParams(
        userId: state.student!.id,
        sum: state.sum,
        date: state.date!,
      ));
      emit(state.copyWith(successfullyCreated: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
    }
  }
}
