part of '../../di/event_service_locator.dart';

class CurrentEventAndFightOutput extends Equatable {
  const CurrentEventAndFightOutput({
    this.currentEvent = const EventOutput.empty(),
    this.currentFight = FightOutput.empty,
  });

  final EventOutput currentEvent;
  final FightOutput currentFight;

  factory CurrentEventAndFightOutput.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CurrentEventAndFightOutput();
    }

    return CurrentEventAndFightOutput(
      currentEvent:
          EventOutput.fromJson(json['currentEvent'] as Map<String, dynamic>),
      currentFight:
          FightOutput.fromJson(json['currentFight'] as Map<String, dynamic>),
    );
  }

  const CurrentEventAndFightOutput.empty()
      : currentEvent = const EventOutput.empty(),
        currentFight = FightOutput.empty;

  bool get isEmpty => this == const EventOutput.empty();
  bool get isNotEmpty => this != const EventOutput.empty();

  @override
  List<Object?> get props => [
        currentEvent,
        currentFight,
      ];
}
