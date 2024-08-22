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
    this.fightStatus = FightStatus.notStarted,
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
  final FightStatus fightStatus;
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
      fightStatus: FightStatus.parse(json.parseString('status')),
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
      'fightStatus': fightStatus.toString(),
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

enum FightStatus {
  notStarted,
  inProgress,
  concluded;

  static FightStatus parse(String status) {
    switch (status) {
      case 'NotStarted':
        return FightStatus.notStarted;
      case 'InProgress':
        return FightStatus.inProgress;
      case 'Concluded':
        return FightStatus.concluded;
      default:
        throw ArgumentError('Invalid status: $status');
    }
  }

  @override
  String toString() {
    switch (this) {
      case FightStatus.notStarted:
        return 'NotStarted';
      case FightStatus.inProgress:
        return 'InProgress';
      case FightStatus.concluded:
        return 'Concluded';
      default:
        throw ArgumentError('Invalid status: $this');
    }
  }
}
