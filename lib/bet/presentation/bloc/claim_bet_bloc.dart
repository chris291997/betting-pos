import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/claim_bet_event.dart';
part '../state/claim_bet_state.dart';

class ClaimBetBloc extends Bloc<ClaimBetEvent, ClaimBetState> {
  ClaimBetBloc(this._betRepository) : super(const ClaimBetState()) {
    on<ClaimBetInitialized>(_onClaimBetInitialized);
    on<ClaimBetSubmitted>(_onClaimBetSubmitted);
  }
  final BetRepository _betRepository;

  void _onClaimBetInitialized(
    ClaimBetInitialized event,
    Emitter<ClaimBetState> emit,
  ) {
    emit(const ClaimBetState.empty());
  }

  void _onClaimBetSubmitted(
    ClaimBetSubmitted event,
    Emitter<ClaimBetState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ClaimBetStatus.loading));

      final claimedBet =
          await _betRepository.claimBet(transactionId: event.transactionId);

      emit(state.copyWith(
          status: ClaimBetStatus.success, betOutput: claimedBet));
    } catch (e) {
      emit(state.copyWith(status: ClaimBetStatus.error));
    }
  }
}
