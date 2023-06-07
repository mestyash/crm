import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm/core/domain/entity/payment/payment_model.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/core/utils/bloc/bloc_utils.dart';
import 'package:crm/features/admin/payments/core/domain/payments_interface.dart';
import 'package:equatable/equatable.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final IPaymentsRepository _repository;

  PaymentsBloc({required IPaymentsRepository repository})
      : _repository = repository,
        super(PaymentsState()) {
    on<PaymentsEventStartDate>(_onStartDateChange);
    on<PaymentsEventEndDate>(_onEndDateChange);
    on<PaymentsEventMode>(_onModeChange);
    on<PaymentsEventSearchStudents>(
      _onSearchStudents,
      transformer: restartable(),
    );
    on<PaymentsEventStudent>(_onStudentChange);
    on<PaymentsEventSearch>(_onSearch, transformer: restartable());
    on<PaymentsEventDelete>(_onDeletePayment);
    on<PaymentsEventPdf>(_onCreatePdf);
  }

  void _onStartDateChange(
    PaymentsEventStartDate event,
    Emitter<PaymentsState> emit,
  ) {
    emit(state.copyWith(startDate: event.date));
    add(PaymentsEventSearch());
  }

  void _onEndDateChange(
    PaymentsEventEndDate event,
    Emitter<PaymentsState> emit,
  ) {
    emit(state.copyWith(endDate: event.date));
    add(PaymentsEventSearch());
  }

  void _onModeChange(
    PaymentsEventMode event,
    Emitter<PaymentsState> emit,
  ) {
    final currentMode = state.mode;
    final newMode = currentMode == PaymentsStateMode.all
        ? PaymentsStateMode.student
        : PaymentsStateMode.all;
    emit(state.copyWith(
      mode: newMode,
      student: Wrapped.value(null),
      payments: [],
    ));
    add(PaymentsEventSearch());
  }

  Future<void> _onSearchStudents(
    PaymentsEventSearchStudents event,
    Emitter<PaymentsState> emit,
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
    PaymentsEventStudent event,
    Emitter<PaymentsState> emit,
  ) {
    emit(state.copyWith(student: Wrapped.value(event.student)));
    add(PaymentsEventSearch());
  }

  Future<void> _onSearch(
    PaymentsEventSearch event,
    Emitter<PaymentsState> emit,
  ) async {
    try {
      if (state.canSearch) {
        emit(state.copyWith(isLoading: true));
        final payments = await _repository.getPaymentsByRange(
          GetPaymentsByRangeParams(
            startDate: state.startDate!,
            endDate: state.endDate!,
            studentId: state.student?.id,
          ),
        );
        emit(state.copyWith(isLoading: false, payments: payments));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
    }
  }

  Future<void> _onDeletePayment(
    PaymentsEventDelete event,
    Emitter<PaymentsState> emit,
  ) async {
    try {
      emit(state.copyWith(isUploading: true));
      await _repository.deletePayment(id: event.id);
      final payments = [...state.payments]
          .where(
            (e) => e.id != event.id,
          )
          .toList();
      emit(state.copyWith(isUploading: false, payments: payments));
    } catch (e) {
      emit(state.copyWith(isUploading: false, isFailure: true));
    }
  }

  Future<void> _onCreatePdf(
    PaymentsEventPdf event,
    Emitter<PaymentsState> emit,
  ) async {
    try {
      emit(state.copyWith(isUploading: true));
      final id = event.data.id;

      final payments = [...state.payments];
      final paymentIndex = payments.indexWhere((e) => e.id == id);
      final payment = payments[paymentIndex];

      if (!payment.hasPdf) {
        final updatedPayment = payment.copyWith(hasPdf: true);
        payments[paymentIndex] = updatedPayment;
        await _repository.setPdfStatus(id: id);
      }
      await _repository.createPdf(data: event.data);
      emit(state.copyWith(isUploading: false, payments: payments));
    } catch (e) {
      emit(state.copyWith(isUploading: false, isFailure: true));
    }
  }
}
