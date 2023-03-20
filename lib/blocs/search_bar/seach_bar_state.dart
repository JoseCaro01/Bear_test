part of 'seach_bar_bloc.dart';

abstract class SeachBarState extends Equatable {
  const SeachBarState();

  @override
  List<Object> get props => [];
}

class SeachBarInitial extends SeachBarState {}

class FilterListState extends SeachBarState {
  const FilterListState({required this.bearList, required this.filter});
  final List<Bear> bearList;
  final String filter;

  List<Bear> get bearFilteredList {
    return bearList
        .where((element) => element.name!.startsWith(filter))
        .toList();
  }
}
