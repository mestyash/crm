import 'package:crm/core/domain/entity/group/group_model.dart';
import 'package:crm/features/common/groups/core/data/groups_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  final GroupsRepository _repository;

  GroupsCubit({
    required GroupsRepository repository,
  })  : _repository = repository,
        super(GroupsState());

  Future<void> loadGroups() async {
    try {
      emit(state.copyWith(isLoading: true));
      // print('zxczxc');
      // await _repository.getGroups();
      // emit(
      emit(state.copyWith(isLoading: false, groups: []));
      // state.copyWith(isLoading: false, groups: data, filteredGroups: data));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
    }
  }

  void onTextChange(String text) {
    final filteredGroups = _filterByText(state.groups!, text);
    emit(state.copyWith(text: text, filteredGroups: filteredGroups));
  }

  // --- utils ---
  List<GroupModel> _filterByText(
    List<GroupModel> groups,
    String text,
  ) {
    return groups.where((e) => e.name.contains(text)).toList();
  }
}
