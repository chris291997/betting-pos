part of '../di/bet_service_locator.dart';

abstract interface class BetRepositoryInterface {
  Future<BetOutput> createBet({required BetInput input});
  Future<List<EventOutput>> getEvents();
  Future<List<FightOutput>> getFights({required String eventId});
  Future<FighterOutput> getFighter({required String fighterId});
}
