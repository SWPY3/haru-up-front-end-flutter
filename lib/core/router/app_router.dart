import 'package:go_router/go_router.dart';
import '../../presentation/pages/splash/splash_screen.dart';
import '../../presentation/pages/login/login_screen.dart';
import '../../presentation/pages/terms/terms_screen.dart';
import '../../presentation/pages/onboarding/onboarding_screen.dart';
import '../../presentation/pages/curation/curation_screen.dart';
import '../../presentation/pages/home/home_screen.dart';
import '../../presentation/pages/mypage/mypage_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String terms = '/terms';
  static const String onboarding = '/onboarding';
  static const String curation = '/curation';
  static const String home = '/home';
  static const String mypage = '/mypage';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.terms,
      builder: (context, state) => const TermsScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.curation,
      builder: (context, state) => const CurationScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.mypage,
      builder: (context, state) => const MypageScreen(),
    ),
  ],
);
