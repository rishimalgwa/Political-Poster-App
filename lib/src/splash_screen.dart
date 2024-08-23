import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:political_poster_app/src/common/di/di.dart';
import 'package:political_poster_app/src/common/widgets/loading_widget.dart';
import 'package:political_poster_app/src/features/auth/domain/persistence/user_dao.dart';
import 'package:political_poster_app/src/navigation/router.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogedIn = false;
  @override
  void initState() {
    super.initState();
    getAuthToken();
    Timer(const Duration(milliseconds: 300), () {
      if (isLogedIn) {
        context.router.pushAndPopUntil(const DashboardRoute(),
            predicate: (route) => false);
      }
      if (!isLogedIn) {
        context.router
            .pushAndPopUntil(const PhoneRoute(), predicate: (route) => false);
      }
    });
  }

  getAuthToken() async {
    isLogedIn = getIt<GetUserDao>().isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
