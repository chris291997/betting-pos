import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/common/component/drop_down/base_drop_down.dart';
import 'package:bet_pos/fight/data/di/fight_service_locator.dart';
import 'package:bet_pos/fight/presentation/bloc/fight_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FightDropdown extends StatelessWidget {
  const FightDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FightListBloc(fightRepository),
      child: BlocConsumer<BetBloc, BetState>(
        listener: (context, state) {
          if (state.input.event.isNotEmpty) {
            context.read<FightListBloc>().add(
                  FightListFetched(state.input.event.id),
                );
          }
        },
        listenWhen: (previous, current) =>
            previous.input.event != current.input.event,
        builder: (context, state) {
          return BlocBuilder<FightListBloc, FightListState>(
            builder: (context, state) {
              final dropdownStatus = switch (state.status) {
                FightListStatus.loading => BaseDropdownStatus.loading,
                FightListStatus.loaded => BaseDropdownStatus.enabled,
                _ => BaseDropdownStatus.disabled,
              };
              final dropdownItems = state.fights
                  .map((fight) => fight.fightNumber.toString())
                  .toList();

              return BaseDropDown(
                status: dropdownStatus,
                header: 'Fight',
                hint: 'Select Fight',
                value: null,
                dropdownItems: dropdownItems,
                onChanged: (value) {
                  final fightOutput = state.fights.firstWhere(
                    (fight) => fight.fightNumber.toString() == value,
                  );

                  context.read<BetBloc>().add(
                        BetFightAdded(fightOutput),
                      );
                },
              );
            },
          );
        },
      ),
    );
  }
}
