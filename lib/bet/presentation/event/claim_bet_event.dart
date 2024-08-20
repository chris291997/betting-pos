part of '../bloc/claim_bet_bloc.dart';

sealed class ClaimBetEvent extends Equatable {
  const ClaimBetEvent();

  @override
  List<Object> get props => [];
}

class ClaimBetInitialized extends ClaimBetEvent {
  const ClaimBetInitialized();
}

class ClaimBetSubmitted extends ClaimBetEvent {
  const ClaimBetSubmitted({
    required this.transactionId,
  });

  final String transactionId;
}
