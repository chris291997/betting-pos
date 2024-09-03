import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:bet_pos/event/presentation/bloc/current_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EventDetails extends HookWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        final currentEventAndFight =
            context.read<CurrentEventBloc>().state.currentEventAndFight;

        context.read<BetBloc>().add(
              BetCurrentEventAndFightAdded(
                currentEventAndFight,
              ),
            );
        return null;
      },
      const [],
    );
    return BlocBuilder<CurrentEventBloc, CurrentEventState>(
      builder: (context, state) {
        final currentEventAndFight = state.currentEventAndFight;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Event Name: ${currentEventAndFight.currentEvent.eventName}',
              style: context.textStyle.subtitle1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 20),
            Text(
              'Fight #${currentEventAndFight.currentFight.fightNumber}',
              style: context.textStyle.subtitle1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }
}
