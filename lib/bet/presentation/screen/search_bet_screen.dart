import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/bloc/bet_details_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/scan_qr_code_option.dart';
import 'package:bet_pos/bet/presentation/screen/claim_bet_screen.dart';
import 'package:bet_pos/common/component/textfield/primary_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SearchBetScreen extends StatelessWidget {
  const SearchBetScreen({super.key});

  static const routeName = '/bet-details';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => BetDetailsBloc(betRepository),
      child: const _SearchBetScreen(),
    );
  }
}

class _SearchBetScreen extends HookWidget {
  const _SearchBetScreen();

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();

    return BetScreenWrapper(
      appBarTitle: 'Transaction Details',
      contentVerticalAlignment: MainAxisAlignment.center,
      content: const [
        ScanQrCodeOption(),
      ],
      nextButtons: [
        PrimarySearchBar(
          searchController: searchController,
          hintText: 'Enter Transaction ID',
          onSearch: (id) {
            if (id.isEmpty) return;

            context.read<BetDetailsBloc>().add(
                  BetDetailsFetchedByTransactionId(id),
                );
            searchController.clear();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (routeContext) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<BetDetailsBloc>(),
                    ),
                  ],
                  child: const ClaimBetScreen(
                    entryPoint: ClaimBetEntryPoint.searched,
                  ),
                );
              }),
            );
          },
        ),
      ],
      onAppbarBackButtonPressed: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/');
        }
      },
    );
  }
}
