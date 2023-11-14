import 'dart:developer';

import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/controllers/home_controller.dart';
import 'package:erecruitment/src/controllers/ongoing_controller.dart';
import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/repositories/user_repository.dart';
import 'package:erecruitment/src/views/dashboard_page.dart';
import 'package:erecruitment/src/views/ongoing_page.dart';
import 'package:erecruitment/src/views/profile_page.dart';
import 'package:erecruitment/src/views/signin_page.dart';
import 'package:erecruitment/src/views/test_page.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../src/views/home_page.dart';
import 'app_route_name.dart';

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
  // errorBuilder: (context, state) => const NotFoundPage(),
  navigatorKey: rootNavigatorKey,
  initialLocation: "/",
  debugLogDiagnostics: true,
  redirect: (context, state) {
    return UserRepository.isLoggedIn();
  },

  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      pageBuilder: ((context, state, child) {
        return buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: DashboardPage(
            widget: child,
            route: state.matchedLocation,
          ),
        );
      }),
      routes: [
        GoRoute(
          path: '/',
          name: AppRouteName.app,
          onExit: (context) {
            return true;
          },
          redirect: (context, state) {
            final oC = Get.put(DashboardController());
            if (oC.isStarting.value) {
              return "/ongoing";
            } else {
              return null;
            }
          },
          pageBuilder: (context, state) {
            return NoTransitionPage(
                child: Container(
              color: Colors.red,
            ));
          },
          routes: [
            GoRoute(
              path: "home",
              name: AppRouteName.home,
              onExit: (context) {
                Get.delete<HomeController>();
                return true;
              },
              pageBuilder: (context, state) {
                return NoTransitionPage(child: HomePage());
              },
            ),
            GoRoute(
              path: "profile",
              name: AppRouteName.profile,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: ProfilePage());
              },
            ),
            GoRoute(
              path: "test",
              name: AppRouteName.test,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: TestPage());
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/ongoing",
      name: AppRouteName.ongoing,
      onExit: (_) {
        if (kDebugMode) {
          print("OngoingController has been deleted");
        }
        Get.delete<OngoingController>();
        return true;
      },
      redirect: (context, state) {
        final oC = Get.put(DashboardController());
        if (oC.isStarting.value) {
          return null;
        } else {
          return "/test";
        }
      },
      pageBuilder: (context, state) {
        Object? extra = state.extra;
        ExamM? exam;
        if (extra != null && extra is Map<String, dynamic>) {
          exam = extra["exam"];
        }
        if (kDebugMode) {
          print("OngoingController has been created");
        }
        final oC = Get.put(OngoingController());
        oC.exams.value = exam ?? examEmpty;
        oC.time.value = exam?.time ?? 40;

        return NoTransitionPage(child: OngoingPage());
      },
    ),
    GoRoute(
      path: '/signin',
      name: AppRouteName.signin,
      builder: (context, state) {
        return SigninPage();
      },
    ),
  ],
);
