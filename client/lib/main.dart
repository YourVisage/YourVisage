import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:client/bloc/bloc_manager.dart';
import 'package:client/bloc/deepFakeImage/fake_bloc.dart';
import 'package:client/bloc/main_bloc.dart';
import 'package:client/bloc/authBloc.dart';
import 'package:client/bloc/userBloc.dart';
import 'package:client/component/text.dart';
import 'package:client/firebase_options.dart';
import 'package:client/helpers/application.dart';
import 'package:client/helpers/shared_pref.dart';
import 'package:client/pages/auth/login/login_page.dart';
import 'package:client/pages/main/home/home_page.dart';
import 'package:client/router/router.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final token = application.getSessionToken();
    print('token: $token');
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (BuildContext context) => BlocManager.mainBloc),
        BlocProvider<AuthBloc>(create: (BuildContext context) => BlocManager.authBloc),
        BlocProvider<UserBloc>(create: (BuildContext context) => BlocManager.userBloc),
        BlocProvider<FakeBloc>(create: (BuildContext context) => BlocManager.fakeBloc),
      ],
      child: OverlaySupport(
          child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: Navkey.navkey,
        onGenerateRoute: AppRouter.generatedRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          splash: Stack(alignment: Alignment.center, children: [
            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(Assets.logo),
            ),
            const CustomText(
              AppText.faceSwappingSoftware,
              fontSize: 16,
              color: ConstantColors.grey,
              fontWeight: FontWeight.bold,
              alignment: Alignment(0, 0.75),
            )
          ]),
          backgroundColor: ConstantColors.black,
          nextScreen: LoginPage(),
          pageTransitionType: PageTransitionType.fade,
          splashTransition: SplashTransition.fadeTransition,
          duration: 3000,
          splashIconSize: double.infinity,
        ),
      )),
    );
  }
}
