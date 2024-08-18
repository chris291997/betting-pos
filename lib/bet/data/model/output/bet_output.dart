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
  final double betAmount;
  final String betDetails;
  final String transactionId;
  final String qrToken;
  final EventOutput event;
  final FightOutput fight;
  final FighterOutput betOn;
  final PosOutput pos;
  final bool isVoid;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory BetOutput.fromJson(Map<String, dynamic> json) {
    return BetOutput(
      id: json.parseString('id'),
      betAmount: json.parseDouble('betAmount'),
      betDetails: json.parseString('betDetails'),
      transactionId: json.parseString('transactionId'),
      qrToken: json.parseString('qrToken'),
      event: EventOutput.fromJson(json['event'] as Map<String, dynamic>),
      fight: FightOutput.fromJson(json['fight'] as Map<String, dynamic>),
      betOn: FighterOutput.fromJson(json['betOn'] as Map<String, dynamic>),
      pos: PosOutput.fromJson(json['pos'] as Map<String, dynamic>),
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

  const BetOutput.empty()
      : id = '',
        betAmount = 0,
        betDetails = '',
        transactionId = '',
        qrToken = '',
        event = const EventOutput.empty(),
        fight = FightOutput.empty,
        betOn = FighterOutput.empty,
        pos = PosOutput.empty,
        isVoid = false,
        createdAt = null,
        updatedAt = null;

  bool get isNotEmpty => this != const BetOutput.empty();

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

extension BetOutputMapper on BetOutput {
  ReceiptDetails toReceiptDetails() {
    return ReceiptDetails(
      transactionId: transactionId,
      eventName: event.eventName,
      eventDate: event.eventDate?.toIso8601String(),
      location: event.location,
      fightNumber: fight.fightNumber,
      betOnName: betOn.name,
      betAmount: betAmount,
      posNumber: pos.posNumber,
      userName: pos.user.username,
      createdAt: createdAt?.toIso8601String() ?? '',
      qrToken: qrToken,
    );
  }
}
