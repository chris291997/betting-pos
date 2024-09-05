part of '../../di/bet_service_locator.dart';

class BetInput extends Equatable {
  const BetInput({
    required this.betAmount,
    required this.betDetails,
    // required this.fight,
    // required this.event,
    // required this.betOn,
    required this.betOnByType,
    required this.currentEventAndFight,
  });

  final double betAmount;
  final String betDetails;
  // final FightOutput fight;
  // final EventOutput event;
  final FighterType betOnByType;
  final CurrentEventAndFightOutput currentEventAndFight;
  // final FighterOutput betOn;

  Map<String, dynamic> toJson() {
    // return {
    //   'betAmount': betAmount,
    //   'betDetails':
    //       'The bet is on ${betOn.id} in the fight between ${fight.walaId} and ${fight.meronId}',
    //   'fightId': fight.id,
    //   'eventId': event.id,
    //   'betOn': betOn.id,
    // };
    return {
      'betAmount': betAmount,
      'betDetails':
          'The bet is on ${currentEventAndFight.currentEvent.id} in the fight between ${currentEventAndFight.currentFight.walaId} and ${currentEventAndFight.currentFight.meronId}',
      'betOn': betOnByType.isWala
          ? currentEventAndFight.currentFight.walaId
          : currentEventAndFight.currentFight.meronId,
    };
  }

  BetInput copyWith({
    double? betAmount,
    String? betDetails,
    // FightOutput? fight,
    // EventOutput? event,
    // FighterOutput? betOn,
    // String? posId,
    FighterType? betOnByType,
    CurrentEventAndFightOutput? currentEventAndFight,
  }) {
    return BetInput(
      betAmount: betAmount ?? this.betAmount,
      betDetails: betDetails ?? this.betDetails,
      // fight: fight ?? this.fight,
      // event: event ?? this.event,
      // betOn: betOn ?? this.betOn,
      betOnByType: betOnByType ?? this.betOnByType,
      currentEventAndFight: currentEventAndFight ?? this.currentEventAndFight,
    );
  }

  const BetInput.empty()
      : betAmount = 0,
        betDetails = '',
        // fight = FightOutput.empty,
        // event = const EventOutput.empty(),
        // betOn = FighterOutput.empty,
        betOnByType = FighterType.wala,
        currentEventAndFight = const CurrentEventAndFightOutput.empty();

  bool get hasEmptyAttribute {
    final json = toJson();
    return json.values.any((value) => value == '' || value == 0);
  }

  // FighterType? get fighterType {
  //   if (betOn.id == fight.walaId) {
  //     return FighterType.wala;
  //   } else if (betOn.id == fight.meronId) {
  //     return FighterType.meron;
  //   }

  //   return null;
  // }

  @override
  List<Object> get props => [
        betAmount,
        betDetails,
        // fight,
        // event,
        // betOn,
        betOnByType,
        currentEventAndFight,
      ];
}
