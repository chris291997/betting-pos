part of '../../di/fight_service_locator.dart';

class FightOutput extends Equatable implements JsonSerializable {
  const FightOutput({
    this.id = '',
    this.eventId = '',
    this.fightNumber = 0,
    this.meronId = '',
    this.walaId = '',
    this.startTime = '',
    this.isLocked = false,
    this.winnerId = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  final String id;
  final String eventId;
  final int fightNumber;
  final String meronId;
  final String walaId;
  final String startTime;
  final bool isLocked;
  final String winnerId;
  final String createdAt;
  final String updatedAt;

  static const empty = FightOutput();

  bool get isEmpty => this == FightOutput.empty;
  bool get isNotEmpty => this != FightOutput.empty;

  factory FightOutput.fromJson(Map<String, dynamic> json) {
    return FightOutput(
      id: json.parseString('id'),
      eventId: json.parseString('eventId'),
      fightNumber: json.parseInt('fightNumber'),
      meronId: json.parseString('meronId'),
      walaId: json.parseString('walaId'),
      startTime: json.parseString('startTime'),
      isLocked: json.parseBool('isLocked'),
      winnerId: json.parseString('winnerId'),
      createdAt: json.parseString('createdAt'),
      updatedAt: json.parseString('updatedAt'),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'fightNumber': fightNumber,
      'meronId': meronId,
      'walaId': walaId,
      'startTime': startTime,
      'isLocked': isLocked,
      'winnerId': winnerId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Map<String, dynamic> toTableJson() {
    return {
      'fightNumber': fightNumber,
      'startTime': startTime,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object> get props => [
        id,
        eventId,
        fightNumber,
        meronId,
        walaId,
        startTime,
        isLocked,
        winnerId,
        createdAt,
        updatedAt,
      ];
}
