import 'dart:convert';

import 'package:bet_pos/authentication/presentation/screen/login_screen.dart';
import 'package:bet_pos/bet/presentation/screen/search_bet_screen.dart';
import 'package:bet_pos/bet/presentation/screen/select_to_bet_screen_v2.dart';
import 'package:bet_pos/common/di/service_locator.dart';
import 'package:bet_pos/dashboard/presentation/screen/pos_dashboard.dart';
import 'package:bet_pos/user/data/di/user_service_locator.dart';
import 'package:bet_pos/user/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
      path: SelectToBetScreenV2.routeName,
      builder: (context, state) {
        return const SelectToBetScreenV2();
      },
    ),
    GoRoute(
      path: SearchBetScreen.routeName,
      builder: (context, state) {
        return const SearchBetScreen();
      },
    ),
  ],
  redirect: (context, state) async {
    final accountBloc = context.read<AccountBloc>();
    final accessToken = await cacheService.read(StorageKey.accessToken);

    // Check if the current date is greater than September 30, 2024
    // final currentDate = DateTime.now();
    // final cutoffDate = DateTime(2024, 9, 30);

    // if (currentDate.isAfter(cutoffDate)) {
    //   return LoginScreen.routeName;
    // }

    if (accessToken != null) {
      if (!JwtDecoder.isExpired(accessToken)) {
        final user = await cacheService.read(StorageKey.loggedUser);
        if (user == null) {
          return LoginScreen.routeName;
        }

        final userOutput = UserOutput.fromJson(jsonDecode(user));

        accountBloc.add(AccountEventUserSet(userOutput));

        return null;
      }
    }

    await Future.wait([
      cacheService.remove(StorageKey.accessToken),
      cacheService.remove(StorageKey.refreshToken),
      cacheService.remove(StorageKey.loggedUser),
    ]);

    return LoginScreen.routeName;
  },
);
