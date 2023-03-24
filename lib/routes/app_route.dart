import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recruitment/src/presentation/pages/auth/login_page.dart';
import '../src/presentation/pages/not_found_page.dart';
import '../src/presentation/pages/welcome_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

GoRouter router = GoRouter(
  errorBuilder: (context, state) => const NotFoundPage(),
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) {
        return const WelcomePage();
      },
    ),
    GoRoute(
      path: '/signin',
      name: 'signin',
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    // ShellRoute(
    //   navigatorKey: shellNavigatorKey,
    //   pageBuilder: ((context, state, child) {
    //     return NoTransitionPage(
    //       child: WebDashboardPage(
    //         route: state.location,
    //         widget: child,
    //       ),
    //     );
    //   }),
    //   routes: [
    //     GoRoute(
    //       path: '/',
    //       name: "/",
    //       pageBuilder: (context, state) {
    //         return NoTransitionPage(
    //             child: Container(
    //           color: Colors.red,
    //         ));
    //       },
    //       routes: [
    //         GoRoute(
    //           path: AppRouteNameMobile.home,
    //           name: AppRouteNameMobile.home,
    //           pageBuilder: (context, state) {
    //             return const NoTransitionPage(
    //               child: WebHomePage(),
    //             );
    //           },
    //         ),
    //         GoRoute(
    //           path: AppRouteNameMobile.attendance,
    //           name: AppRouteNameMobile.attendance,
    //           pageBuilder: (context, state) {
    //             return const NoTransitionPage(child: WebAttendancePage());
    //           },
    //         ),
    //         GoRoute(
    //           path: AppRouteNameMobile.request,
    //           name: AppRouteNameMobile.request,
    //           pageBuilder: (context, state) {
    //             return const NoTransitionPage(child: WebRequestPage());
    //           },
    //         ),
    //         GoRoute(
    //           path: AppRouteNameMobile.profile,
    //           name: AppRouteNameMobile.profile,
    //           pageBuilder: (context, state) {
    //             return const NoTransitionPage(child: WebProfilePage());
    //           },
    //         ),
    //         GoRoute(
    //           path: AppRouteNameMobile.blast,
    //           name: AppRouteNameMobile.blast,
    //           pageBuilder: (context, state) {
    //             return const NoTransitionPage(child: WebBlastPage());
    //           },
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  ],
  initialLocation: "/welcome",
  debugLogDiagnostics: true,
  routerNeglect: true,
  // urlPathStrategy: UrlPathStrategy.path,
);
