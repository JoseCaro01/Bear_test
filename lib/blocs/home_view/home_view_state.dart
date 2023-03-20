part of 'home_view_bloc.dart';

abstract class HomeViewState extends Equatable {
  const HomeViewState();

  @override
  List<Object> get props => [];
}

class HomeViewInitial extends HomeViewState {}

class LoadingBearsState extends HomeViewState {}

class LoadedBearsState extends HomeViewState {
  const LoadedBearsState({required this.bearList});

  final List<Bear> bearList;

  @override
  List<Object> get props => [bearList];
}

class ErrorLoadingBears extends HomeViewState {
  const ErrorLoadingBears({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
