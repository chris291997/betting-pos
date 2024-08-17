import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/common/component/drop_down/base_drop_down.dart';
import 'package:bet_pos/event/data/di/event_service_locator.dart';
import 'package:bet_pos/event/presentation/bloc/event_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDropdown extends StatelessWidget {
  const EventDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => EventListBloc(eventRepository)
        ..add(
          EventListEventFetched(),
        ),
      child: BlocBuilder<EventListBloc, EventListState>(
        builder: (context, state) {
          final dropdownStatus = switch (state.status) {
            EventListStatus.loading => BaseDropdownStatus.loading,
            EventListStatus.loaded => BaseDropdownStatus.enabled,
            _ => BaseDropdownStatus.disabled,
          };

          final dropdownItems =
              state.events.map((event) => event.eventName).toList();
          return BaseDropDown(
            status: dropdownStatus,
            header: 'Event',
            hint: 'Select Event',
            value: null,
            dropdownItems: dropdownItems,
            onChanged: (eventName) {
              final event = state.events.firstWhere(
                (event) => event.eventName == eventName,
              );
              context.read<BetBloc>().add(
                    BetEventAdded(event),
                  );
            },
          );
        },
      ),
    );
  }
}
