import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recruitment/routes/app_route_name.dart';
import 'package:recruitment/src/presentation/pages/auth/login_page.dart';
import 'package:recruitment/src/presentation/pages/dashboard_page.dart';
import 'package:recruitment/src/presentation/pages/disc/disc_page.dart';
import 'package:recruitment/src/presentation/pages/home/home_page.dart';
import 'package:recruitment/src/presentation/pages/papi/papi_page.dart';
import 'package:recruitment/src/presentation/pages/user/users_page.dart';
import '../src/presentation/pages/blast/web_blast_page.dart';
import '../src/presentation/pages/chat/web_chat_page.dart';
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
    GoRoute(
      path: '/chat/:no',
      name: 'chat',
      builder: (context, state) {
        String no = state.params["no"] ?? "";
        return WebChatPage(
          no: no,
        );
      },
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      pageBuilder: ((context, state, child) {
        return NoTransitionPage(
          child: DashboardPage(
            route: state.location,
            widget: child,
          ),
        );
      }),
      routes: [
        GoRoute(
          path: '/',
          name: "/",
          pageBuilder: (context, state) {
            return NoTransitionPage(
                child: Container(
              color: Colors.red,
            ));
          },
          routes: [
            GoRoute(
              path: AppRouteName.home,
              name: AppRouteName.home,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: HomePage());
              },
            ),

            GoRoute(
              path: AppRouteName.user,
              name: AppRouteName.user,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: UsersPage());
              },
            ),

            GoRoute(
              path: AppRouteName.disc,
              name: AppRouteName.disc,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: DiscPage());
              },
            ),
            GoRoute(
              path: AppRouteName.papiKostick,
              name: AppRouteName.papiKostick,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: PapiPage());
              },
            ),
            // GoRoute(
            //   path: AppRouteNameMobile.request,
            //   name: AppRouteNameMobile.request,
            //   pageBuilder: (context, state) {
            //     return const NoTransitionPage(child: WebRequestPage());
            //   },
            // ),
            // GoRoute(
            //   path: AppRouteNameMobile.profile,
            //   name: AppRouteNameMobile.profile,
            //   pageBuilder: (context, state) {
            //     return const NoTransitionPage(child: WebProfilePage());
            //   },
            // ),
            GoRoute(
              path: AppRouteName.blast,
              name: AppRouteName.blast,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: WebBlastPage());
              },
            ),
          ],
        ),
      ],
    ),
  ],
  initialLocation: "/welcome",
  debugLogDiagnostics: true,
  routerNeglect: true,
  // urlPathStrategy: UrlPathStrategy.path,
);
