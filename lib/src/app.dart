import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:political_poster_app/src/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:political_poster_app/src/features/auth/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:political_poster_app/src/features/dashboard/presentation/cubit/leaders_photo_cubit/leaders_photo_cubit.dart';
import 'package:political_poster_app/src/navigation/router.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final AppRouter _router = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LeadersPhotoCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router.config(
          deepLinkBuilder: (deeplink) {
            return const DeepLink([SplashRoute()]);
          },
        ),
        title: 'Political Poster App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
      ),
    );
  }
}
