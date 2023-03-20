import 'package:bear_test/models/bear.dart';
import 'package:bear_test/services/bear_api/bear_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_view_event.dart';
part 'detail_view_state.dart';

class DetailViewBloc extends Bloc<DetailViewEvent, DetailViewState> {
  final BearRepository bearRepository;
  DetailViewBloc({required this.bearRepository}) : super(DetailViewInitial()) {
    on<DetailViewEvent>((event, emit) {});

    on<LoadBearEvent>(
      (event, emit) async {
        emit(LoadingBearState());
        try {
          final Bear bear = await bearRepository.getBear(id: event.id);
          emit(LoadedBearState(bear: bear));
        } catch (e) {
          emit(ErrorLoadingBear(message: e.toString()));
        }
      },
    );
  }
}
