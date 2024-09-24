import '../../bottom_nav_bar.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/admin/presentation/views/admin_view.dart';
import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/auth/presentation/views/verification_view.dart';
import '../../features/admin/presentation/views/add_in_store_view.dart';
import '../../features/auth/presentation/views/forget_password_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/admin/presentation/views/remove_from_store_view.dart';
import '../../features/admin/presentation/views/users_informatins_view.dart';
import 'package:west_elbalad/features/splash/presentation/views/splash_view.dart';
import 'package:west_elbalad/features/profile/presentation/views/profile_view.dart';
import 'package:west_elbalad/features/auth/presentation/views/widgets/sign_up_successfully.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/onBoardingView';
  static const kBottomNavBarController = '/bottomNavBarController';
  static const kSigninView = '/signinView';
  static const kSignupView = '/signupView';
  static const kVerificationView = '/verificationView';
  static const kWrapper = '/wrapper';
  static const kProfileView = '/profileView';
  static const kforgetPasswordView = '/forgetPasswordView';
  static const kSignupSuccessView = '/signupSuccessView';
  static const kAdminView = '/adminView';
  static const kusersInformatinsView = '/usersInformatinsView';
  static const kAddInStoreView = '/AddInStoreView';
  static const kRemoveFromStoreView = '/RemoveFromStoreView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: kBottomNavBarController,
        builder: (context, state) => const BottomNavBarController(),
      ),
      GoRoute(
        path: kProfileView,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: kSigninView,
        builder: (context, state) => const SigninView(),
      ),
      GoRoute(
        path: kSignupView,
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: kWrapper,
        builder: (context, state) => const Wrapper(),
      ),
      GoRoute(
        path: kVerificationView,
        builder: (context, state) => const VerificationView(),
      ),
      GoRoute(
        path: kforgetPasswordView,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: kSignupSuccessView,
        builder: (context, state) => const SignUpSuccessfully(),
      ),
      GoRoute(
        path: kAdminView,
        builder: (context, state) => const AdminView(),
      ),
      GoRoute(
        path: kusersInformatinsView,
        builder: (context, state) => const UsersInformatinsView(),
      ),
      GoRoute(
          path: kAddInStoreView,
          builder: (context, state) => const AddInStoreView()),
      GoRoute(
          path: kRemoveFromStoreView,
          builder: (context, state) => const RemoveFromStoreView()),
    ],
  );
}
