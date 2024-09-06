part of '../../di/bet_service_locator.dart';

class BetOutput extends Equatable {
  const BetOutput({
    required this.id,
    required this.betAmount,
    required this.winnings,
    required this.betDetails,
    required this.transactionId,
    required this.qrToken,
    required this.event,
    required this.fight,
    required this.betOn,
    required this.pos,
    required this.isVoid,
    required this.isClaimed,
    required this.claimedBy,
    this.claimedAt,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final double betAmount;
  final double winnings;
  final String betDetails;
  final String transactionId;
  final String qrToken;
  final EventOutput event;
  final FightOutput fight;
  final FighterOutput betOn;
  final PosOutput pos;
  final bool isVoid;
  final bool isClaimed;
  final UserOutput claimedBy;
  final DateTime? claimedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory BetOutput.fromJson(Map<String, dynamic> json) {
    return BetOutput(
      id: json.parseString('id'),
      betAmount: json.parseDouble('betAmount'),
      winnings: double.tryParse(json.parseString('winnings')) ?? 0.0,
      betDetails: json.parseString('betDetails'),
      transactionId: json.parseString('transactionId'),
      qrToken: json.parseString('qrToken'),
      event: EventOutput.fromJson(json['event'] as Map<String, dynamic>),
      fight: FightOutput.fromJson(json['fight'] as Map<String, dynamic>),
      betOn: FighterOutput.fromJson(json['betOn'] as Map<String, dynamic>),
      pos: PosOutput.fromJson(json['pos'] as Map<String, dynamic>),
      isVoid: json.parseBool('isVoid'),
      isClaimed: json.parseBool('claimed'),
      claimedBy:
          UserOutput.fromJson(json['claimedBy'] as Map<String, dynamic>? ?? {}),
      claimedAt: json.parseDateTime('claimedAt'),
      createdAt: json.parseDateTime('createdAt'),
      updatedAt: json.parseDateTime('updatedAt'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'betAmount': betAmount,
      'winnings': winnings,
      'betDetails': betDetails,
      'transactionId': transactionId,
      'qrToken': qrToken,
      'event': event.toJson(),
      'fight': fight.toJson(),
      'betOn': betOn.toJson(),
      'pos': pos.toJson(),
      'isVoid': isVoid,
      'claimed': isClaimed,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  const BetOutput.empty()
      : id = '',
        betAmount = 0,
        winnings = 0,
        betDetails = '',
        transactionId = '',
        qrToken = '',
        event = const EventOutput.empty(),
        fight = FightOutput.empty,
        betOn = FighterOutput.empty,
        pos = PosOutput.empty,
        isVoid = false,
        isClaimed = false,
        claimedBy = UserOutput.empty,
        claimedAt = null,
        createdAt = null,
        updatedAt = null;

  bool get isNotEmpty => this != const BetOutput.empty();

  bool get isClaimable =>
      betOn.id == fight.winnerId && winnings > 0 && !isClaimed;

  FighterType get betOnType =>
      fight.walaId == betOn.id ? FighterType.wala : FighterType.meron;

  @override
  List<Object?> get props => [
        id,
        betAmount,
        winnings,
        betDetails,
        transactionId,
        qrToken,
        event,
        fight,
        betOn,
        pos,
        isVoid,
        isClaimed,
        claimedBy,
        claimedAt,
        createdAt,
        updatedAt,
      ];
}

extension BetOutputMapper on BetOutput {
  ReceiptDetails toReceiptDetails() {
    final eventDateFormatted = event.eventDate != null
        ? DateFormat('MM/dd/yyyy hh:mm:ss aa').format(event.eventDate!)
        : null;
    final createdAtFormatted = event.createdAt != null
        ? DateFormat('MM/dd/yyyy hh:mm:ss aa').format(event.createdAt!)
        : null;

    final claimedAtFormatted = claimedAt != null
        ? DateFormat('MM/dd/yyyy hh:mm:ss aa').format(claimedAt!)
        : null;

    return ReceiptDetails(
      transactionId: transactionId,
      eventName: event.eventName,
      eventDate: eventDateFormatted,
      location: event.location,
      fightNumber: fight.fightNumber,
      // betOnName: betOn.name,
      betOnName: betOnType.name.toUpperCase(),
      betAmount: betAmount,
      winnings: winnings,
      posNumber: pos.posNumber,
      userName: pos.user.username,
      createdAt: createdAtFormatted ?? '',
      qrToken: qrToken,
      claimedBy: claimedBy.username,
      claimedAt: claimedAtFormatted ?? '',
    );
  }
}
