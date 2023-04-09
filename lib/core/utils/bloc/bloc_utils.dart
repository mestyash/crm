import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}

extension CubitExt<T> on Cubit<T> {
  void safeEmit(T state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      emit(state);
    }
  }
}
