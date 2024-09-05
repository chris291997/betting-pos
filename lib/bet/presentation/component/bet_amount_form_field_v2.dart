import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/common/component/keyboard/custom_virtual_keyboard.dart';
import 'package:bet_pos/common/component/textfield/text_field_placeholder.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:bet_pos/event/presentation/bloc/current_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:new_virtual_keyboard/virtual_keyboard.dart';

class BetAmountFormFieldV2 extends HookWidget {
  const BetAmountFormFieldV2({super.key});

  @override
  Widget build(BuildContext context) {
    final betAmountInString = useState('');

    void onSavedAmout(String value) {
      final amount = double.tryParse(value) ?? 0;
      context.read<BetBloc>().add(
            BetAmountAdded(amount),
          );
    }

    void onKeyPress(VirtualKeyboardKey key) {
      if (key.keyType == VirtualKeyboardKeyType.String) {
        betAmountInString.value += key.text ?? '';
        onSavedAmout(betAmountInString.value);
      } else if (key.keyType == VirtualKeyboardKeyType.Action) {
        switch (key.action) {
          case VirtualKeyboardKeyAction.Backspace:
            betAmountInString.value = betAmountInString.value
                .substring(0, betAmountInString.value.length - 1);
            onSavedAmout(betAmountInString.value);
            break;
          default:
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header(),
        const SizedBox(
          height: 10,
        ),
        TextFieldPlaceholder(
          labelText: (double.tryParse(betAmountInString.value) ?? 0).toString(),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomVirtualKeyboard(onKeyPress: (key) => onKeyPress(key)),
      ],
    );
  }
}

class _Header extends HookWidget {
  const _Header();

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
        final eventName = state.currentEventAndFight.currentEvent.eventName;
        final fightNumber = state.currentEventAndFight.currentFight.fightNumber;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Bet', style: context.textStyle.subtitle1),
            const SizedBox(width: 8),
            Text(eventName,
                style: context.textStyle.subtitle2,
                overflow: TextOverflow.ellipsis),
            const SizedBox(width: 8),
            Text('#$fightNumber',
                style: context.textStyle.subtitle2,
                overflow: TextOverflow.ellipsis),
          ],
        );
      },
    );
  }
}
