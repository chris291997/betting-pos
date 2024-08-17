part of '../../di/bet_service_locator.dart';

class BetInput extends Equatable {
  const BetInput({
    required this.betAmount,
    required this.betDetails,
    required this.fightId,
    required this.eventId,
    required this.betOn,
    required this.posId,
  });

  final int betAmount;
  final String betDetails;
  final String fightId;
  final String eventId;
  final String betOn;
  final String posId;

  Map<String, dynamic> toJson() {
    return {
      'betAmount': betAmount,
      'betDetails': betDetails,
      'fightId': fightId,
      'eventId': eventId,
      'betOn': betOn,
      'posId': posId,
    };
  }

  BetInput copyWith({
    int? betAmount,
    String? betDetails,
    String? fightId,
    String? eventId,
    String? betOn,
    String? posId,
  }) {
    return BetInput(
      betAmount: betAmount ?? this.betAmount,
      betDetails: betDetails ?? this.betDetails,
      fightId: fightId ?? this.fightId,
      eventId: eventId ?? this.eventId,
      betOn: betOn ?? this.betOn,
      posId: posId ?? this.posId,
    );
  }

  const BetInput.empty()
      : betAmount = 0,
        betDetails = '',
        fightId = '',
        eventId = '',
        betOn = '',
        posId = '';

  @override
  List<Object> get props =>
      [betAmount, betDetails, fightId, eventId, betOn, posId];
}
