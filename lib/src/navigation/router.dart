import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:political_poster_app/src/features/auth/presentation/pages/add_profile_page.dart';
import 'package:political_poster_app/src/features/auth/presentation/pages/phone_page.dart';
import 'package:political_poster_app/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:political_poster_app/src/features/dashboard/presentation/pages/edit_profile_page.dart';
import 'package:political_poster_app/src/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: AddProfileRoute.page,
        ),
        AutoRoute(
          page: PhoneRoute.page,
        ),
        AutoRoute(
          page: DashboardRoute.page,
        ),
        AutoRoute(
          page: EditProfileRoute.page,
        ),
      ];
}
