import 'package:bear_test/models/bear.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seach_bar_event.dart';
part 'seach_bar_state.dart';

class SeachBarBloc extends Bloc<SeachBarEvent, SeachBarState> {
  SeachBarBloc() : super(SeachBarInitial()) {
    on<SeachBarEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FilteredEvent>((event, emit) {
      emit(FilterListState(bearList: event.bearList, filter: event.filter));
    });
  }
}
