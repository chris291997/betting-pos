part of '../bloc/claim_bet_bloc.dart';

class ClaimBetState extends Equatable {
  const ClaimBetState({
    this.status = ClaimBetStatus.initial,
    this.betOutput = const BetOutput.empty(),
  });

  final ClaimBetStatus status;
  final BetOutput betOutput;

  ClaimBetState copyWith({
    ClaimBetStatus? status,
    BetOutput? betOutput,
  }) {
    return ClaimBetState(
      status: status ?? this.status,
      betOutput: betOutput ?? this.betOutput,
    );
  }

  const ClaimBetState.empty() : this();

  @override
  List<Object> get props => [
        status,
        betOutput,
      ];
}

enum ClaimBetStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == ClaimBetStatus.initial;
  bool get isLoading => this == ClaimBetStatus.loading;
  bool get isSuccess => this == ClaimBetStatus.success;
  bool get isError => this == ClaimBetStatus.error;
}
