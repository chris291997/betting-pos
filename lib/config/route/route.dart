import 'package:bet_pos/bet/presentation/screen/select_to_bet_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _eventNavigatorKey = GlobalKey<NavigatorState>();
// final _fightertNavigatorKey = GlobalKey<NavigatorState>();
// final _usertNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: SelectToBetScreen.routeName,
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: SelectToBetScreen.routeName,
      builder: (context, state) {
        return const SelectToBetScreen();
      },
    ),
  ],
  redirect: (context, state) async {
    // final accountBloc = context.read<AccountBloc>();
    // final accessToken = await cacheService.read(StorageKey.accessToken);

    // if (accessToken != null) {
    //   accountBloc.add(AccountEventLoggedUserRequested());

    //   return null;
    // }

    // return LoginScreen.routeName;
  },
);
