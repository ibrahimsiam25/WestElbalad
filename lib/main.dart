import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:west_elbalad/core/manager/fetch_user_image/fetch_user_image_cubit.dart';
import 'core/service/get_it_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/service/custom_bloc_observer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:west_elbalad/core/utils/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';
import 'supabase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseOptions.projectUrl,
    anonKey: SupabaseOptions.publishableKey,
  );
  setupGetIt();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Bloc.observer = CustomBlocObserver();
  await ScreenUtil.ensureScreenSize();
  await SharedPref.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
        );

        return BlocProvider(
          create: (context) => getIt<FetchUserImageCubit>()..fetchUserImage(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: appFontCairo,
              scaffoldBackgroundColor: AppColors.lightGrey,
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('ar', 'AR'),
            ],
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
