import 'package:coffee_ui/core/route/route_names.dart';
import 'package:coffee_ui/features/presentation/home_page/view/page.dart';
import 'package:coffee_ui/features/presentation/mixing%20page/view/page.dart';
import 'package:coffee_ui/features/presentation/quantity_page/view/page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final RouteObserver<PageRoute> routeObserver = RouteObserver();

  static final goRoutes = GoRouter(
    initialLocation: RouteName.homePage,
    observers: [routeObserver],
    routes: [
      GoRoute(
        path: RouteName.homePage,
        builder: (context, state) => const HomePage(),
        pageBuilder: (context, state) => customTransition(
            page: const HomePage(),
            duration: const Duration(milliseconds: 100)),
        name: RouteName.homePage,
        routes: [
          GoRoute(
            path: RouteName.quantityPage.replaceAll('/', ''),
            builder: (context, state) =>
                QuantityPage(coffeeName: state.extra.toString()),
            pageBuilder: (context, state) => customTransition(
                page: QuantityPage(coffeeName: state.extra.toString()),
                duration: const Duration(milliseconds: 40)),
            name: RouteName.quantityPage,
            routes: [
              GoRoute(
                path: RouteName.mixingPage.replaceAll('/', ''),
                builder: (context, state) => const MixingPage(),
                pageBuilder: (context, state) => customTransition(
                    page: const MixingPage(),
                    duration: const Duration(milliseconds: 40)),
                name: RouteName.mixingPage,
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Page<dynamic> customTransition(
    {required Widget page, required Duration duration}) {
  return CustomTransitionPage(
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}
