part of '../bloc/bet_bloc.dart';

class BetState extends Equatable {
  const BetState({
    this.status = BetStatus.initial,
    this.input = const BetInput.empty(),
    this.betOutput = const BetOutput.empty(),
    this.error,
  });

  final BetStatus status;
  final BetInput input;
  final BetOutput betOutput;
  final String? error;

  BetState copyWith({
    BetStatus? status,
    BetInput? input,
    BetOutput? betOutput,
    String? error,
  }) {
    return BetState(
      status: status ?? this.status,
      input: input ?? this.input,
      betOutput: betOutput ?? this.betOutput,
      error: error,
    );
  }

  const BetState.empty()
      : status = BetStatus.initial,
        input = const BetInput.empty(),
        betOutput = const BetOutput.empty(),
        error = null;


  @override
  List<Object?> get props => [
        status,
        input,
        betOutput,
        error,
      ];
}

enum BetStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == BetStatus.initial;
  bool get isLoading => this == BetStatus.loading;
  bool get isSuccess => this == BetStatus.success;
  bool get isError => this == BetStatus.error;
}
