import '../../bottom_nav_bar.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/home/domian/entites/phone_entites.dart';
import '../../features/admin/presentation/views/admin_view.dart';
import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/admin/presentation/views/orders_view.dart';
import '../../features/auth/presentation/views/verification_view.dart';
import '../../features/admin/presentation/views/add_in_store_view.dart';
import '../../features/auth/presentation/views/forget_password_view.dart';
import '../../features/admin/presentation/views/edit_new_phones_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/home/presentation/views/new_phone_details_view.dart';
import '../../features/admin/presentation/views/users_informatins_view.dart';
import '../../features/used_phones/presentation/views/add_used_phone_view.dart';
import '../../features/shopping_cart/presentation/views/shopping_cart_view.dart';
import 'package:west_elbalad/features/splash/presentation/views/splash_view.dart';
import 'package:west_elbalad/features/admin/presentation/views/edit_used_phones_view.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/views/finish_order_view.dart';
import 'package:west_elbalad/features/auth/presentation/views/widgets/sign_up_successfully.dart';
import 'package:west_elbalad/features/used_phones/presentation/views/used_phones_details_view.dart';

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
  static const kOrdersView = '/OrdersView';
  static const kusersInformatinsView = '/usersInformatinsView';
  static const kAddInStoreView = '/AddInStoreView';
  static const kNewPhonesView = '/NewPhonesView';
  static const kUsedPhonesView = '/UsedPhonesView';
  static const kShoppingCartView = '/ShoppingCartView';
  static const kNewPhoneDetailsView = '/NewPhoneDetailsView';
  static const kUsedPhoneDetailsView = '/UsedPhoneDetailsView';
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
        builder: (context, state) => const AddInStoreView(),
      ),
      GoRoute(
        path: kNewPhonesView,
        builder: (context, state) => const EditNewPhonesView(),
      ),
      GoRoute(
        path: kUsedPhonesView,
        builder: (context, state) => const EditUsedPhonesView(),
      ),
      GoRoute(
          path: kShoppingCartView,
          builder: (context, state) => const ShoppingCartView()),
      GoRoute(
          path: kAddUsedPhoneView,
          builder: (context, state) => const AddUsedPhoneView()),
      GoRoute(
        path: kNewPhoneDetailsView,
        builder: (context, state) => NewPhoneDetailsView(
          phoneEntites: state.extra as PhoneEntites,
        ),
      ),
      GoRoute(
        path: kUsedPhoneDetailsView,
        builder: (context, state) => UsedPhonesDetailsView(
          usedPhonesEntities: state.extra as UsedPhonesEntities,
        ),
      ),
      GoRoute(
          path: kFinishOrderView,
          builder: (context, state) => FinishOrderView()),
      GoRoute(
        path: kOrdersView,
        builder: (context, state) => OrdersView(),
      )
    ],
  );
}
