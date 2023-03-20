import 'package:bear_test/models/bear.dart';
import 'package:bear_test/services/bear_api/bear_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_view_event.dart';
part 'home_view_state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  final BearRepository bearRepository;
  HomeViewBloc({required this.bearRepository}) : super(HomeViewInitial()) {
    on<HomeViewEvent>((event, emit) {});
    on<LoadBearsEvent>(
      (event, emit) async {
        emit(LoadingBearsState());
        try {
          final List<Bear> bears = await bearRepository.getBearList();
          emit(LoadedBearsState(bearList: bears));
        } catch (e) {
          emit(ErrorLoadingBears(message: e.toString()));
        }
      },
    );
  }
}
