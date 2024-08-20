part of '../di/bet_service_locator.dart';

class BetRepository implements BetRepositoryInterface {
  const BetRepository({
    required BetRemoteSource betRemoteSource,
    required EventRemoteSource eventRemoteSource,
    required FightRemoteSource fightRemoteSource,
    required FighterRemoteSource fighterRemoteSource,
  })  : _betRemoteSource = betRemoteSource,
        _eventRemoteSource = eventRemoteSource,
        _fightRemoteSource = fightRemoteSource,
        _fighterRemoteSource = fighterRemoteSource;

  final BetRemoteSource _betRemoteSource;
  final EventRemoteSource _eventRemoteSource;
  final FightRemoteSource _fightRemoteSource;
  final FighterRemoteSource _fighterRemoteSource;

  @override
  Future<BetOutput> createBet({required BetInput input}) async {
    return _betRemoteSource.createBet(input: input);
  }

  @override
  Future<List<EventOutput>> getEvents() async {
    return _eventRemoteSource.getEvents();
  }

  @override
  Future<List<FightOutput>> getFights({required String eventId}) async {
    return _fightRemoteSource.getFights(eventId: eventId);
  }

  @override
  Future<FighterOutput> getFighter({required String fighterId}) async {
    return _fighterRemoteSource.getFighter(fighterId: fighterId);
  }

  @override
  Future<BetOutput> findBetDetailsByTransactionId(
      {required String transactionId}) async {
    return _betRemoteSource.findBetDetailsByTransactionId(
        transactionId: transactionId);
  }

  @override
  Future<BetOutput> findBetDetailsByQrToken({required String qrToken}) async {
    return _betRemoteSource.findBetDetailsByQrToken(qrToken: qrToken);
  }

  @override
  Future<BetOutput> claimBet({required String transactionId}) async {
    return _betRemoteSource.claimBet(transactionId: transactionId);
  }
}
