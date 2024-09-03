import 'package:bet_pos/common/util/dio_error_parser.dart';
import 'package:bet_pos/event/data/di/event_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part '../event/current_event_event.dart';
part '../state/current_event_state.dart';

class CurrentEventBloc extends Bloc<CurrentEventEvent, CurrentEventState> {
  CurrentEventBloc(this._eventRepository) : super(const CurrentEventState()) {
    on<CurrentEventRequested>(_onCurrentEventRequested);
  }

  final EventRepositoryInterface _eventRepository;

  void _onCurrentEventRequested(
    CurrentEventRequested event,
    Emitter<CurrentEventState> emit,
  ) async {
    emit(state.copyWith(status: CurrentEventStatus.loading));
    try {
      final currentEventAndFight = await _eventRepository.getCurrentEvent();

      emit(state.copyWith(
        status: CurrentEventStatus.success,
        currentEventAndFight: currentEventAndFight,
      ));
    } on DioException catch (e) {
      final errorMessage = DioErrorParser.handleError(e);
      emit(state.copyWith(
          status: CurrentEventStatus.error, errorMessage: errorMessage));
    }
  }
}
