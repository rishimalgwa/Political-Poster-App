// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddProfileRoute.name: (routeData) {
      final args = routeData.argsAs<AddProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddProfilePage(
          key: args.key,
          phoneNumer: args.phoneNumer,
        ),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardPage(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditProfilePage(),
      );
    },
    PhoneRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PhonePage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [AddProfilePage]
class AddProfileRoute extends PageRouteInfo<AddProfileRouteArgs> {
  AddProfileRoute({
    Key? key,
    required String phoneNumer,
    List<PageRouteInfo>? children,
  }) : super(
          AddProfileRoute.name,
          args: AddProfileRouteArgs(
            key: key,
            phoneNumer: phoneNumer,
          ),
          initialChildren: children,
        );

  static const String name = 'AddProfileRoute';

  static const PageInfo<AddProfileRouteArgs> page =
      PageInfo<AddProfileRouteArgs>(name);
}

class AddProfileRouteArgs {
  const AddProfileRouteArgs({
    this.key,
    required this.phoneNumer,
  });

  final Key? key;

  final String phoneNumer;

  @override
  String toString() {
    return 'AddProfileRouteArgs{key: $key, phoneNumer: $phoneNumer}';
  }
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PhonePage]
class PhoneRoute extends PageRouteInfo<void> {
  const PhoneRoute({List<PageRouteInfo>? children})
      : super(
          PhoneRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
