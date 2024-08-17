import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/event/data/di/event_service_locator.dart';
import 'package:bet_pos/fight/data/di/fight_service_locator.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/bet_event.dart';
part '../state/bet_state.dart';

class BetBloc extends Bloc<BetEvent, BetState> {
  BetBloc(this._betRepository) : super(const BetState()) {
    on<BetInitialized>(_onBetInitialized);
    on<BetEventAdded>(_onBetEventAdded);
    on<BetFightAdded>(_onBetFightAdded);
    on<BetFighterSelected>(_onBetFighterSelected);
    on<BetAmountAdded>(_onBetAmountAdded);
    on<BetSubmitted>(_onBetSubmitted);
  }

  final BetRepository _betRepository;

  void _onBetInitialized(BetInitialized event, Emitter<BetState> emit) {
    emit(const BetState.empty());
  }

  void _onBetEventAdded(BetEventAdded event, Emitter<BetState> emit) {
    emit(state.copyWith(
      input: state.input.copyWith(
        event: event.event,
        fight: FightOutput.empty,
        betOn: FighterOutput.empty,
      ),
    ));
  }

  void _onBetFightAdded(BetFightAdded event, Emitter<BetState> emit) {
    emit(state.copyWith(
      input: state.input.copyWith(fight: event.fight, betOn: FighterOutput.empty),
    ));
  }

  void _onBetFighterSelected(BetFighterSelected event, Emitter<BetState> emit) {
    emit(state.copyWith(
      input: state.input.copyWith(betOn: event.betOn),
    ));
  }

  void _onBetAmountAdded(BetAmountAdded event, Emitter<BetState> emit) {
    emit(state.copyWith(
      input: state.input.copyWith(betAmount: event.amount),
    ));
  }

  void _onBetSubmitted(BetSubmitted event, Emitter<BetState> emit) async {
    try {
      emit(state.copyWith(status: BetStatus.loading));
      await _betRepository.createBet(input: state.input);

      emit(state.copyWith(status: BetStatus.success));
    } catch (e) {
      emit(state.copyWith(status: BetStatus.error));
    }
  }
}
