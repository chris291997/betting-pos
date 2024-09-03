part of '../bloc/current_event_bloc.dart';

class CurrentEventState extends Equatable {
  const CurrentEventState({
    this.status = CurrentEventStatus.initial,
    this.currentEventAndFight = const CurrentEventAndFightOutput.empty(),
    this.errorMessage,
  });

  final CurrentEventStatus status;
  final CurrentEventAndFightOutput currentEventAndFight;
  final String? errorMessage;

  CurrentEventState copyWith({
    CurrentEventStatus? status,
    CurrentEventAndFightOutput? currentEventAndFight,
    String? errorMessage,
  }) {
    return CurrentEventState(
      status: status ?? this.status,
      currentEventAndFight: currentEventAndFight ?? this.currentEventAndFight,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  const CurrentEventState.initial() : this();

  @override
  List<Object?> get props => [
        status,
        currentEventAndFight,
        errorMessage,
      ];
}

enum CurrentEventStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == CurrentEventStatus.initial;
  bool get isLoading => this == CurrentEventStatus.loading;
  bool get isSuccess => this == CurrentEventStatus.success;
  bool get isError => this == CurrentEventStatus.error;
}
