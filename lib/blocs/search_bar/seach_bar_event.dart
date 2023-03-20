part of 'seach_bar_bloc.dart';

abstract class SeachBarEvent extends Equatable {
  const SeachBarEvent();

  @override
  List<Object> get props => [];
}

class FilteredEvent extends SeachBarEvent {
  const FilteredEvent({required this.bearList, required this.filter});

  final List<Bear> bearList;

  final String filter;
}
