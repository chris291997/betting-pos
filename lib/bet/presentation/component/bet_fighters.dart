import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/select_bet_card.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:bet_pos/fighter/presentation/bloc/fighter_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class BetFighters extends StatelessWidget {
  const BetFighters({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _FighterCard(
          fighterType: FighterType.wala,
        ),
        SizedBox(
          height: 20,
        ),
        _FighterCard(
          fighterType: FighterType.meron,
        ),
      ],
    );
  }
}

class _FighterCard extends StatelessWidget {
  const _FighterCard({
    required this.fighterType,
  });

  final FighterType fighterType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => FighterDetailsBloc(fighterRepository),
      child: BlocConsumer<BetBloc, BetState>(
        listener: (context, state) {
          final fightId = fighterType.isWala
              ? state.input.fight.walaId
              : state.input.fight.meronId;

          if (fightId.isNotEmpty) {
            context.read<FighterDetailsBloc>().add(
                  FighterDetailsFetched(
                    fightId,
                  ),
                );
          }
        },
        listenWhen: (previous, current) =>
            previous.input.fight != current.input.fight,
        buildWhen: (previous, current) =>
            previous.input.betOn != current.input.betOn ||
            previous.input.fight != current.input.fight,
        builder: (context, betState) {
          return BlocBuilder<FighterDetailsBloc, FighterDetailsState>(
            builder: (context, state) {
              final fighter = state.fighter;

              print('isSelected: ${betState.input.betOn.id == fighter.id}');

              if (state.status.isLoading) {
                return const _CardShimmer();
              }

              if (state.status.isLoaded && betState.input.fight.isNotEmpty) {
                return SelectBetCard(
                  fighterOutput: fighter,
                  fighterType: fighterType,
                  isSelected: betState.input.betOn.id == fighter.id,
                  onTap: () {
                    print('Fighter selected: ${fighter.name}');
                    context.read<BetBloc>().add(
                          BetFighterSelected(fighter),
                        );
                  },
                );
              }

              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}

class _CardShimmer extends StatelessWidget {
  const _CardShimmer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: const SizedBox(),
      ),
    );
  }
}
