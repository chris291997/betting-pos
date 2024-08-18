part of '../bloc/bet_details_bloc.dart';

class BetDetailsState extends Equatable {
  const BetDetailsState({
    this.status = BetDetailsStatus.initial,
    this.betOutput = const BetOutput.empty(),
  });

  final BetDetailsStatus status;
  final BetOutput betOutput;

  BetDetailsState copyWith({
    BetDetailsStatus? status,
    BetOutput? betOutput,
  }) {
    return BetDetailsState(
      status: status ?? this.status,
      betOutput: betOutput ?? this.betOutput,
    );
  }

  const BetDetailsState.empty() : this();

  @override
  List<Object> get props => [
        status,
        betOutput,
      ];
}

enum BetDetailsStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == BetDetailsStatus.initial;
  bool get isLoading => this == BetDetailsStatus.loading;
  bool get isSuccess => this == BetDetailsStatus.success;
  bool get isError => this == BetDetailsStatus.error;
}
