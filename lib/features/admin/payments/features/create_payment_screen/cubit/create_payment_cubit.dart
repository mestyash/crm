import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'create_payment_state.dart';

class CreatePaymentCubit extends Cubit<CreatePaymentState> {
  CreatePaymentCubit() : super(CreatePaymentState());

  void onSumChange(String text) {
    try {
      final sum = double.parse(text);
      emit(state.copyWith(sum: sum));
    } catch (e) {
      emit(state.copyWith(textFailure: true));
    }
  }

  void onDateChange(DateTime date) {
    emit(state.copyWith(date: date));
  }

  Future<void> onSave() async {
    try {
      emit(state.copyWith(isLoading: true));
      emit(state.copyWith(successfullyCreated: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: false));
    }
  }
}
