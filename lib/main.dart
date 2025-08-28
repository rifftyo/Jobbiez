import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/routes/app_pages.dart';
import 'package:jobbiez/injection.dart' as di;
import 'package:jobbiez/presentation/pages/home/home_page.dart';
import 'package:jobbiez/presentation/pages/splash/splash_page.dart';
import 'package:jobbiez/presentation/provider/add_review_provider.dart';
import 'package:jobbiez/presentation/provider/apply_job_provider.dart';
import 'package:jobbiez/presentation/provider/auth_provider.dart';
import 'package:jobbiez/presentation/provider/job_category_provider.dart';
import 'package:jobbiez/presentation/provider/job_detail_provider.dart';
import 'package:jobbiez/presentation/provider/last_job_provider.dart';
import 'package:jobbiez/presentation/provider/login_provider.dart';
import 'package:jobbiez/presentation/provider/my_applications_provider.dart';
import 'package:jobbiez/presentation/provider/profile_user_provider.dart';
import 'package:jobbiez/presentation/provider/register_provider.dart';
import 'package:jobbiez/presentation/provider/search_job_provider.dart';
import 'package:jobbiez/presentation/provider/tab_job_detail_provider.dart';
import 'package:jobbiez/presentation/provider/tab_job_type_provider.dart';
import 'package:jobbiez/presentation/provider/top_job_provider.dart';
import 'package:jobbiez/presentation/provider/update_profile_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<LoginProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<RegisterProvider>()),
        ChangeNotifierProvider(
          create: (_) => di.locator<AuthProvider>()..checkAuth(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ProfileUserProvider>(),
        ),
        ChangeNotifierProvider(create: (_) => di.locator<TopJobProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<LastJobProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<SearchJobProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<TabJobTypeProvider>()),
        ChangeNotifierProvider(
          create: (_) => di.locator<TabJobDetailProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<JobCategoryProvider>(),
        ),
        ChangeNotifierProvider(create: (_) => di.locator<JobDetailProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<AddReviewProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<ApplyJobProvider>()),
        ChangeNotifierProvider(
          create: (_) => di.locator<UpdateProfileProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MyApplicationsProvider>(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: appPages,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: kColorSchemeLight,
              fontFamily: 'Manrope',
            ),
            home: _buildHome(auth),
          );
        },
      ),
    );
  }

  Widget _buildHome(AuthProvider auth) {
    if (auth.isLoggedIn == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (auth.isLoggedIn == true) {
      return const HomePage();
    } else {
      return const SplashPage();
    }
  }
}
