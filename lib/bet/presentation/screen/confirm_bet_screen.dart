import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/bet/presentation/component/bet_payment_details.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/betted_fighter.dart';
import 'package:bet_pos/bet/presentation/component/payment_option.dart';
import 'package:bet_pos/bet/presentation/screen/receipt_screen.dart';
import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmBetScreen extends StatelessWidget {
  const ConfirmBetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BetBloc, BetState>(
      listener: (context, state) {
        print('Bet State: ${state.status}');
        if (state.status.isSuccess) {
          context.read<BetBloc>().add(BetInitialized());
          print('Bet Submitted');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReceiptScreen(
                betOutput: state.betOutput,
              ),
            ),
          );
        }
        
      },
      builder: (context, state) {
        return BetScreenWrapper(
          appBarTitle: 'Payment',
          content: const [
            BettedFighterCard(),
            SizedBox(
              height: 30,
            ),
            Divider(),
            SizedBox(
              height: 30,
            ),
            BetPaymentDetails(),
            SizedBox(
              height: 30,
            ),
            PaymentOption(),
            SizedBox(
              height: 30,
            ),
          ],
          nextButtons: [
            BetNextStepButton(
              label: 'Confirm Payment',
              state: state.status.isLoading
                  ? PrimaryButtonState.loading
                  : PrimaryButtonState.enabled,
              onPressed: () {
                context.read<BetBloc>().add(BetSubmitted());
                print('tapped');
              },
            ),
          ],
        );
      },
    );
  }
}
