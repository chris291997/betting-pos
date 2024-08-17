part of '../bloc/bet_bloc.dart';

class BetState extends Equatable {
  const BetState({
    this.status = BetStatus.initial,
    this.input = const BetInput.empty(),
  });

  final BetStatus status;
  final BetInput input;

  BetState copyWith({
    BetStatus? status,
    BetInput? input,
  }) {
    return BetState(
      status: status ?? this.status,
      input: input ?? this.input,
    );
  }

  const BetState.empty()
      : status = BetStatus.initial,
        input = const BetInput.empty();

  @override
  List<Object> get props => [
        status,
        input,
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
