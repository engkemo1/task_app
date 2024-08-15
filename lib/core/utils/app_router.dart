import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/utils/routes.dart';
import 'package:task/features/home/data/model/grades_model.dart';
import 'package:task/features/home/presentation/views/screen/class_screen/add_class_screen.dart';
import 'package:task/features/home/presentation/views/screen/class_screen/classes_screen.dart';
import 'package:task/features/home/presentation/views/screen/grade_screen/add_grade_screen.dart';
import 'package:task/features/home/presentation/views/screen/grade_screen/grades_screen.dart';
import 'package:task/features/home/presentation/views/screen/home_screen.dart';
import 'package:task/features/authentication/presentation/views/screens/login_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.kLogin,
    routes: [
      GoRoute(
        path: Routes.kLogin,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: Routes.kHome,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.kAddClass,
        builder: (context, state) {
          final gradeId = state.extra as String?;
          if (gradeId == null) {
            // Handle the case where gradeId is null, e.g., redirect to another screen or show an error.
            return const HomeScreen(); // Example fallback
          }
          return AddClassScreen(gradeId: gradeId);
        },
      ),
      GoRoute(
        path: Routes.kAddGrade,
        builder: (context, state) => AddGradeScreen(),
      ),
      GoRoute(
        path: Routes.kGrades,
        builder: (context, state) => GradesScreen(),
      ),
      GoRoute(
        path: Routes.kClass,
        builder: (context, state) {
          final gradesModel = state.extra as GradesModel?;
          if (gradesModel == null) {
            // Handle the case where gradesModel is null
            return const HomeScreen(); // Example fallback
          }
          return ClassesScreen(gradesModel: gradesModel);
        },
      ),
    ],
  );
}
