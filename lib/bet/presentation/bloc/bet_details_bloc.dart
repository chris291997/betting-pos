import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/bet_details_event.dart';
part '../state/bet_details_state.dart';

class BetDetailsBloc extends Bloc<BetDetailsEvent, BetDetailsState> {
  BetDetailsBloc(this._betRepository) : super(const BetDetailsState()) {
    on<BetDetailsInitial>(_onBetDetailsInitial);
    on<BetDetailsFetchedByTransactionId>(_onBetDetailsFetchedByTransactionId);
    on<BetDetailsFetchedByQrToken>(_onBetDetailsFetchedByQrToken);
  }

  final BetRepository _betRepository;

  void _onBetDetailsInitial(
      BetDetailsInitial event, Emitter<BetDetailsState> emit) {
    emit(const BetDetailsState.empty());
  }

  void _onBetDetailsFetchedByTransactionId(
      BetDetailsFetchedByTransactionId event,
      Emitter<BetDetailsState> emit) async {
    try {
      emit(state.copyWith(status: BetDetailsStatus.loading));

      final result = await _betRepository.findBetDetailsByTransactionId(
          transactionId: event.transactionId);

      emit(state.copyWith(status: BetDetailsStatus.success, betOutput: result));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: BetDetailsStatus.error));
    }
  }

  void _onBetDetailsFetchedByQrToken(
      BetDetailsFetchedByQrToken event, Emitter<BetDetailsState> emit) async {
    try {
      emit(state.copyWith(status: BetDetailsStatus.loading));

      final result =
          await _betRepository.findBetDetailsByQrToken(qrToken: event.qrToken);

      emit(state.copyWith(status: BetDetailsStatus.success, betOutput: result));
    } catch (e) {
      emit(state.copyWith(status: BetDetailsStatus.error));
    }
  }
}
