part of '../../di/bet_service_locator.dart';

class BetRemoteSource {
  const BetRemoteSource(this._manager);

  final NetworkManager _manager;

  static const String betPath = '/bets';
  static const String transactionsPath = '/transaction';
  static const String qrPath = '/qr';

  Future<BetOutput> createBet({required BetInput input}) async {
    final response = await _manager.post(
      betPath,
      data: input.toJson(),
    );

    return BetOutput.fromJson(response.data);
  }

  Future<BetOutput> findBetDetailsByTransactionId({required String transactionId}) async {
    final response = await _manager.get(
      '$betPath/$transactionsPath/$transactionId',
    );

    return BetOutput.fromJson(response.data);
  }

  Future<BetOutput> findBetDetailsByQrToken({required String qrToken}) async {
    final response = await _manager.get(
      '$betPath/$qrPath/$qrToken',
    );

    return BetOutput.fromJson(response.data);
  }

  Future<BetOutput> claimBet({required String transactionId}) async {
    final response = await _manager.post(
      '$betPath/$transactionId/claim',
    );

    return BetOutput.fromJson(response.data);
  }
}
