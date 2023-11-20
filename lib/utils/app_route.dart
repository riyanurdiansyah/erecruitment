import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:erecruitment/src/controllers/home_controller.dart';
import 'package:erecruitment/src/controllers/ongoing_controller.dart';
import 'package:erecruitment/src/controllers/test_controller.dart';
import 'package:erecruitment/src/controllers/user_controller.dart';
import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/repositories/user_repository.dart';
import 'package:erecruitment/src/views/dashboard_page.dart';
import 'package:erecruitment/src/views/kelola_test_detail.page.dart';
import 'package:erecruitment/src/views/kelola_test_page.dart';
import 'package:erecruitment/src/views/kelola_user_page.dart';
import 'package:erecruitment/src/views/ongoing_page.dart';
import 'package:erecruitment/src/views/profile_page.dart';
import 'package:erecruitment/src/views/result_page.dart';
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
              path: AppRouteName.home,
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
              path: AppRouteName.profile,
              name: AppRouteName.profile,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: ProfilePage());
              },
            ),
            GoRoute(
              path: AppRouteName.test,
              name: AppRouteName.test,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: TestPage());
              },
            ),
            GoRoute(
              path: AppRouteName.result,
              name: AppRouteName.result,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: ResultPage());
              },
            ),
            GoRoute(
              path: AppRouteName.kelolaUser,
              name: AppRouteName.kelolaUser,
              onExit: (context) {
                Get.delete<UserController>();
                return true;
              },
              pageBuilder: (context, state) {
                Get.put(UserController());
                return NoTransitionPage(child: KelolaUserPage());
              },
            ),
            GoRoute(
              path: AppRouteName.kelolaTest,
              name: AppRouteName.kelolaTest,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: KelolaTestPage());
              },
              routes: [
                GoRoute(
                  path: ":id",
                  name: AppRouteName.kelolaTestDetail,
                  onExit: (context) {
                    Get.delete<TestController>();
                    return true;
                  },
                  pageBuilder: (context, state) {
                    String? examId = state.pathParameters["id"];

                    Get.put(TestController()).examId.value = examId!;
                    return NoTransitionPage(
                      child: KelolaTestDetailPage(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/ongoing",
      name: AppRouteName.ongoing,
      onExit: (_) {
        final oC = Get.find<OngoingController>();
        oC.cameraController.dispose();
        Get.delete<OngoingController>();
        debugPrint("OngoingController has been deleted");
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
        final oC = Get.put(OngoingController());
        if (kDebugMode) {
          print("OngoingController has been created");
        }
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
