import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/common/component/drop_down/base_drop_down.dart';
import 'package:bet_pos/common/theme/theme.dart';
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

              final fights = state.fights;

              return BaseDropDown(
                status: dropdownStatus,
                header: 'Fight',
                hint: dropdownStatus.isEnabled && fights.isEmpty?  'No Available Fights': 'Select Fight',
                value: null,
                dropdownWidth: 50,
                dropdownItems: fights
                    .map((FightOutput event) => DropdownMenuItem<FightOutput>(
                          value: event,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              event.fightNumber.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: context.textStyle.button,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (fight) {
                  if (fight != null) {
                    context.read<BetBloc>().add(
                          BetFightAdded(fight),
                        );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
