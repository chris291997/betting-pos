// import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
// import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
// import 'package:bet_pos/bet/presentation/component/bet_continue_button.dart';
// import 'package:bet_pos/bet/presentation/component/bet_fighters.dart';
// import 'package:bet_pos/bet/presentation/component/bet_amount_form_field.dart';
// import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
// import 'package:bet_pos/bet/presentation/component/event_dropdown.dart';
// import 'package:bet_pos/bet/presentation/component/fight_dropdown.dart';
// import 'package:bet_pos/common/theme/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// class SelectToBetScreen extends StatelessWidget {
//   const SelectToBetScreen({super.key});

//   static const routeName = '/bet';

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => BetBloc(betRepository),
//       child: BetScreenWrapper(
//         appBarTitle: 'Place Your Bet',
//         content: [
//           const SizedBox(height: 20),
//           Text('Bet Details', style: context.textStyle.headline5),
//           const SizedBox(height: 30),
//           const EventDropdown(),
//           const SizedBox(height: 20),
//           const FightDropdown(),
//           const SizedBox(height: 20),
//           const BetFighters(),
//           const SizedBox(height: 20),
//           const BetAmountFormField(),
//           const SizedBox(height: 20),
//         ],
//         nextButtons: const [BetContinueButton()],
//         onAppbarBackButtonPressed: () {
//           if (context.canPop()) {
//             context.pop();
//           } else {
//             context.go('/');
//           }
//         },
//       ),
//     );
//   }
// }
