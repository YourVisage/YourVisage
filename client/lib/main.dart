import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:client/component/text.dart';
import 'package:client/pages/auth/login/login_page.dart';
import 'package:client/router/router.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
