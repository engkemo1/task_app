import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:task/features/home/data/repo/home_repo_implentions.dart';
import 'package:task/features/home/presentation/home_cubit/home_cubit.dart';
import 'core/constants/app_colors.dart';
import 'core/database/local/cache_helper.dart';
import 'core/database/network/dio-helper.dart';
import 'core/utils/app_router.dart';

String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences for local caching
  await CacheHelper.init();

  // Initialize Dio for network requests
  await DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(HomeRepoImplementation())
            ..getAllGrades() // Load all grades when app starts
            ..getAllClasses(), // Load all classes when app starts
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          fontFamily: 'Cairo',
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: const Color(0xfffef7ff),
        ),
        debugShowCheckedModeBanner: false,

        // Initialize FlutterSmartDialog for global dialog management
        builder: FlutterSmartDialog.init(),

        // Configure the router for navigation
        routerConfig: AppRouter.router,
      ),
    );
  }
}
