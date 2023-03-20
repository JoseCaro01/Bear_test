part of 'home_view_bloc.dart';

abstract class HomeViewEvent extends Equatable {
  const HomeViewEvent();

  @override
  List<Object> get props => [];
}

class LoadBearsEvent extends HomeViewEvent {
  const LoadBearsEvent();
}
