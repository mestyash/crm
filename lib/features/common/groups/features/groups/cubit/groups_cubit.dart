import 'package:crm/core/domain/entity/group/group_model.dart';
import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/features/common/groups/core/data/groups_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  final GroupsRepository _repository;
  final CurrentUserCubit _currentUserCubit;

  GroupsCubit({
    required GroupsRepository repository,
    required CurrentUserCubit currentUserCubit,
  })  : _repository = repository,
        _currentUserCubit = currentUserCubit,
        super(GroupsState());

  Future<void> loadGroups() async {
    try {
      emit(state.copyWith(isLoading: true));
      final List<GroupModel> groups;

      final userState = _currentUserCubit.state!;

      if (userState.isAdmin) {
        groups = await _repository.getGroups();
      } else {
        groups = await _repository.getGroupsByTeacherId(
          id: userState.userData.id,
        );
      }

      final filteredGroups = _filterByText(groups, state.text);

      emit(state.copyWith(
        isLoading: false,
        groups: groups,
        filteredGroups: filteredGroups,
      ));
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
