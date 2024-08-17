import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/fighter_details_event.dart';
part '../state/fight_details_state.dart';

class FighterDetailsBloc
    extends Bloc<FighterDetailsEvent, FighterDetailsState> {
  FighterDetailsBloc(this._fightRepository)
      : super(const FighterDetailsState()) {
    on<FighterDetailsFetched>(_onFighterDetailsFetched);
  }

  final FighterRepository _fightRepository;

  void _onFighterDetailsFetched(
      FighterDetailsFetched event, Emitter<FighterDetailsState> emit) async {
    try {
      emit(state.copyWith(status: FighterDetailsStatus.loading));

      final fighter = await _fightRepository.getFighterDetails(event.fighterId);

      emit(state.copyWith(
        status: FighterDetailsStatus.loaded,
        fighter: fighter,
      ));
    } catch (e) {
      emit(state.copyWith(status: FighterDetailsStatus.error));
    }
  }
}
