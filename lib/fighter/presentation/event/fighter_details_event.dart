part of '../bloc/fighter_details_bloc.dart';

sealed class FighterDetailsEvent extends Equatable {
  const FighterDetailsEvent();

  @override
  List<Object> get props => [];
}

final class FighterDetailsFetched extends FighterDetailsEvent {
  const FighterDetailsFetched(this.fighterId);
  final String fighterId;
}
