import '../../bottom_nav_bar.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/home/domian/entites/phone_entites.dart';
import '../../features/admin/presentation/views/admin_view.dart';
import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/auth/presentation/views/verification_view.dart';
import '../../features/admin/presentation/views/add_in_store_view.dart';
import '../../features/home/presentation/views/phone_details_view.dart';
import '../../features/auth/presentation/views/forget_password_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/admin/presentation/views/remove_from_store_view.dart';
import '../../features/admin/presentation/views/users_informatins_view.dart';
import '../../features/used_phones/presentation/views/add_used_phone_view.dart';
import '../../features/shopping_cart/presentation/views/shopping_cart_view.dart';
import 'package:west_elbalad/features/splash/presentation/views/splash_view.dart';
import 'package:west_elbalad/features/profile/presentation/views/profile_view.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/views/finish_order_view.dart';
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
  static const kShoppingCartView = '/ShoppingCartView';
  static const kPhoneDetailsView = '/PhoneDetailsView';
  static const kAddUsedPhoneView = '/AddUsedPhoneView';
  static const kFinishOrderView = '/FinishOrderView';
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
      GoRoute(
          path: kShoppingCartView,
          builder: (context, state) => const ShoppingCartView()),
      GoRoute(
          path: kAddUsedPhoneView,
          builder: (context, state) => const AddUsedPhoneView()),
      GoRoute(
          path: kPhoneDetailsView,
          builder: (context, state) => PhoneDetailsView(
                phoneEntites: state.extra as PhoneEntites,
              )),
      GoRoute(
          path: kFinishOrderView,
          builder: (context, state) =>  FinishOrderView(

          )),
    ],
  );
}
