part of 'detail_view_bloc.dart';

abstract class DetailViewState extends Equatable {
  const DetailViewState();

  @override
  List<Object> get props => [];
}

class DetailViewInitial extends DetailViewState {}

class LoadingBearState extends DetailViewState {}

class LoadedBearState extends DetailViewState {
  const LoadedBearState({required this.bear});

  final Bear bear;

  @override
  List<Object> get props => [bear.id!];
}

class ErrorLoadingBear extends DetailViewState {
  const ErrorLoadingBear({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
