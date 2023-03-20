part of 'detail_view_bloc.dart';

abstract class DetailViewEvent extends Equatable {
  const DetailViewEvent();

  @override
  List<Object> get props => [];
}

class LoadBearEvent extends DetailViewEvent {
  const LoadBearEvent({required this.id});
  final int id;
  @override
  List<Object> get props => [id];
}
