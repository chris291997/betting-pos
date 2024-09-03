part of '../bloc/bet_bloc.dart';

sealed class BetEvent extends Equatable {
  const BetEvent();

  @override
  List<Object> get props => [];
}

final class BetInitialized extends BetEvent {}

// final class BetEventAdded extends BetEvent {
//   final EventOutput event;

//   const BetEventAdded(this.event);

//   @override
//   List<Object> get props => [event];
// }

final class BetCurrentEventAndFightAdded extends BetEvent {
  final CurrentEventAndFightOutput currentEventAndFight;

  const BetCurrentEventAndFightAdded(this.currentEventAndFight);

  @override
  List<Object> get props => [currentEventAndFight];
}

// final class BetFightAdded extends BetEvent {
//   final FightOutput fight;

//   const BetFightAdded(this.fight);

//   @override
//   List<Object> get props => [fight];
// }

// final class BetFighterSelected extends BetEvent {
//   final FighterOutput betOn;

//   const BetFighterSelected(this.betOn);

//   @override
//   List<Object> get props => [betOn];
// }

// final class BetFightAdded extends BetEvent {
//   final FightOutput fight;

//   const BetFightAdded(this.fight);

//   @override
//   List<Object> get props => [fight];
// }

// final class BetFighterSelected extends BetEvent {
//   final FighterOutput betOn;

//   const BetFighterSelected(this.betOn);

//   @override
//   List<Object> get props => [betOn];
// }

final class BetFighterSelectedByType extends BetEvent {
  final FighterType betOn;

  const BetFighterSelectedByType(this.betOn);

  @override
  List<Object> get props => [betOn];
}

final class BetAmountAdded extends BetEvent {
  final double amount;

  const BetAmountAdded(this.amount);

  @override
  List<Object> get props => [amount];
}

final class BetSubmitted extends BetEvent {}
