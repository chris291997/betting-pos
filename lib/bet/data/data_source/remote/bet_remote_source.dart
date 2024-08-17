part of '../../di/bet_service_locator.dart';

class BetRemoteSource {
  const BetRemoteSource(this._manager);

  final NetworkManager _manager;

  static const String betPath = '/bets';

  Future<BetOutput> createBet({required BetInput input}) async {
    final response = await _manager.post(
      betPath,
      data: input.toJson(),
    );

    return BetOutput.fromJson(response.data);
  }
}
