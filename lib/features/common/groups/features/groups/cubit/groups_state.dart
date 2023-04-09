// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'groups_cubit.dart';

class GroupsState extends Equatable {
  const GroupsState({
    this.isLoading = false,
    this.isFailure = false,
    // ----
    this.text = '',
    // ----
    this.groups = null,
    this.filteredGroups = null,
  });

  final bool isLoading;
  final bool isFailure;
  // ----
  final String text;
  // ----
  final List<GroupModel>? groups;
  final List<GroupModel>? filteredGroups;

  bool get isScreenLoading => isLoading && groups == null;

  GroupsState copyWith({
    bool? isLoading,
    bool? isFailure,
    // ----
    String? text,
    // ----
    List<GroupModel>? groups,
    List<GroupModel>? filteredGroups,
  }) {
    return GroupsState(
      isLoading: isLoading ?? this.isLoading,
      isFailure: isFailure ?? this.isFailure,
      // ----
      text: text ?? this.text,
      // ----
      groups: groups ?? this.groups,
      filteredGroups: filteredGroups ?? this.filteredGroups,
    );
  }

  @override
  List<Object?> get props {
    return [
      isLoading,
      isFailure,
      // ----
      text,
      // ----
      groups,
      filteredGroups,
    ];
  }
}
