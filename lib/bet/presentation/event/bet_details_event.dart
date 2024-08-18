part of '../bloc/bet_details_bloc.dart';

sealed class BetDetailsEvent extends Equatable {
  const BetDetailsEvent();

  @override
  List<Object> get props => [];
}

final class BetDetailsInitial extends BetDetailsEvent {}

final class BetDetailsFetchedByTransactionId extends BetDetailsEvent {
  const BetDetailsFetchedByTransactionId(this.transactionId);

  final String transactionId;

  @override
  List<Object> get props => [transactionId];
}

final class BetDetailsFetchedByQrToken extends BetDetailsEvent {
  const BetDetailsFetchedByQrToken(this.qrToken);

  final String qrToken;

  @override
  List<Object> get props => [qrToken];
}
