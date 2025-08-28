import 'package:flutter/material.dart';
import 'package:jobbiez/common/routes/app_routes.dart';
import 'package:jobbiez/presentation/pages/applications/applications_page.dart';
import 'package:jobbiez/presentation/pages/apply/apply_page.dart';
import 'package:jobbiez/presentation/pages/detail/detail_page.dart';
import 'package:jobbiez/presentation/pages/home/home_page.dart';
import 'package:jobbiez/presentation/pages/login/login_page.dart';
import 'package:jobbiez/presentation/pages/profile/profile_page.dart';
import 'package:jobbiez/presentation/pages/register/register_page.dart';
import 'package:jobbiez/presentation/pages/search/search_page.dart';
import 'package:jobbiez/presentation/pages/splash/splash_page.dart';

final Map<String, WidgetBuilder> appPages = {
  AppRoutes.splash: (context) => const SplashPage(),
  AppRoutes.login: (context) => const LoginPage(),
  AppRoutes.register: (context) => const RegisterPage(),
  AppRoutes.home: (context) => const HomePage(),
  AppRoutes.profile: (context) => const ProfilePage(),
  AppRoutes.applications: (context) => const ApplicationsPage(),
  AppRoutes.search: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final query = args['query'] as String? ?? '';
    final category = args['category'] as String?;
    final type = args['type'] as String?;

    return SearchPage(query: query, category: category ?? '', type: type ?? '');
  },
  AppRoutes.detail: (context) {
    final idJob = ModalRoute.of(context)!.settings.arguments as String;

    return DetailPage(idJob: idJob);
  },
  AppRoutes.apply: (context) {
    final idJob = ModalRoute.of(context)!.settings.arguments as String;

    return ApplyPage(jobId: idJob);
  },
};
