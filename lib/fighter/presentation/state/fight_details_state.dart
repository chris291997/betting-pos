part of '../bloc/fighter_details_bloc.dart';

class FighterDetailsState extends Equatable {
  const FighterDetailsState({
    this.status = FighterDetailsStatus.initial,
    this.fighterId = '',
    this.fighter = const FighterOutput(),
  });

  final FighterDetailsStatus status;
  final String fighterId;
  final FighterOutput fighter;

  FighterDetailsState copyWith({
    FighterDetailsStatus? status,
    String? fighterId,
    FighterOutput? fighter,
  }) {
    return FighterDetailsState(
      status: status ?? this.status,
      fighterId: fighterId ?? this.fighterId,
      fighter: fighter ?? this.fighter,
    );
  }

  const FighterDetailsState.initial() : this();

  @override
  List<Object> get props => [
        status,
        fighterId,
        fighter,
      ];
}

enum FighterDetailsStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == FighterDetailsStatus.initial;
  bool get isLoading => this == FighterDetailsStatus.loading;
  bool get isLoaded => this == FighterDetailsStatus.loaded;
  bool get isError => this == FighterDetailsStatus.error;
}
