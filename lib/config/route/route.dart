import 'dart:convert';

import 'package:bet_pos/authentication/presentation/screen/login_screen.dart';
import 'package:bet_pos/bet/presentation/screen/bet_details_screen.dart';
import 'package:bet_pos/bet/presentation/screen/select_to_bet_screen.dart';
import 'package:bet_pos/common/di/service_locator.dart';
import 'package:bet_pos/dashboard/presentation/screen/pos_dashboard.dart';
import 'package:bet_pos/user/data/di/user_service_locator.dart';
import 'package:bet_pos/user/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _eventNavigatorKey = GlobalKey<NavigatorState>();
// final _fightertNavigatorKey = GlobalKey<NavigatorState>();
// final _usertNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: PosDashboard.routeName,
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: PosDashboard.routeName,
      builder: (context, state) {
        return const PosDashboard();
      },
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: SelectToBetScreen.routeName,
      builder: (context, state) {
        return const SelectToBetScreen();
      },
    ),
    GoRoute(
      path: BetDetailsScreen.routeName,
      builder: (context, state) {
        return const BetDetailsScreen();
      },
    ),
  ],
  redirect: (context, state) async {
    final accountBloc = context.read<AccountBloc>();
    final accessToken = await cacheService.read(StorageKey.accessToken);

    if (accessToken != null) {
      final user = await cacheService.read(StorageKey.loggedUser);
      if (user == null) {
        return LoginScreen.routeName;
      }

      final userOutput = UserOutput.fromJson(jsonDecode(user));

      accountBloc.add(AccountEventUserSet(userOutput));

      return null;
    }

    return LoginScreen.routeName;
  },
);
