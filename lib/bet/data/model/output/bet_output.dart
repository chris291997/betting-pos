part of '../../di/bet_service_locator.dart';

class BetOutput extends Equatable {
  const BetOutput({
    required this.id,
    required this.betAmount,
    required this.betDetails,
    required this.transactionId,
    required this.qrToken,
    required this.event,
    required this.fight,
    required this.betOn,
    required this.pos,
    required this.isVoid,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final int betAmount;
  final String betDetails;
  final String transactionId;
  final String qrToken;
  final EventOutput event;
  final FightOutput fight;
  final FighterOutput betOn;
  final UserOutput pos;
  final bool isVoid;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory BetOutput.fromJson(Map<String, dynamic> json) {
    return BetOutput(
      id: json.parseString('id'),
      betAmount: json.parseInt('betAmount'),
      betDetails: json.parseString('betDetails'),
      transactionId: json.parseString('transactionId'),
      qrToken: json.parseString('qrToken'),
      event: EventOutput.fromJson(json['event'] as Map<String, dynamic>),
      fight: FightOutput.fromJson(json['fight'] as Map<String, dynamic>),
      betOn: FighterOutput.fromJson(json['betOn'] as Map<String, dynamic>),
      pos: UserOutput.fromJson(json['pos'] as Map<String, dynamic>),
      isVoid: json.parseBool('isVoid'),
      createdAt: json.parseDateTime('createdAt'),
      updatedAt: json.parseDateTime('updatedAt'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'betAmount': betAmount,
      'betDetails': betDetails,
      'transactionId': transactionId,
      'qrToken': qrToken,
      'event': event.toJson(),
      'fight': fight.toJson(),
      'betOn': betOn.toJson(),
      'pos': pos.toJson(),
      'isVoid': isVoid,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        betAmount,
        betDetails,
        transactionId,
        qrToken,
        event,
        fight,
        betOn,
        pos,
        isVoid,
        createdAt,
        updatedAt,
      ];
}
