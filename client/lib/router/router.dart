import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:client/component/text.dart';
import 'package:client/pages/auth/login/login_page.dart';
import 'package:client/pages/auth/selfie/camera_page.dart';
import 'package:client/pages/main/home/home_page.dart';
import 'package:client/pages/main/profile/profile_page.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class AppRouter {
  static Route<dynamic> generatedRoute(settings) {
    // Map<dynamic, dynamic>? args;
    // if (settings.arguments != null) args = settings.arguments;
    switch (settings.name) {
      case RouterPath.login:
        return SwipeablePageRoute(
          builder: (_) => const LoginPage(),
        );
      case RouterPath.home:
        return SwipeablePageRoute(
          builder: (_) => const HomePage(),
        );
      case RouterPath.camera:
        return SwipeablePageRoute(
          builder: (_) => const CameraPage(),
        );
      case RouterPath.profile:
        return PageTransition(
            child: const ProfilePage(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300));
      case RouterPath.homeMain:
        return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      default:
        return SwipeablePageRoute(
          builder: (context) {
            return AnimatedSplashScreen(
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
            );
          },
          settings: settings,
          canSwipe: false,
          transitionDuration: const Duration(milliseconds: 200),
          canOnlySwipeFromEdge: false,
        );
    }
  }
}

// _getValueByKey(Map<dynamic, dynamic>? args, String key) {
//   try {
//     return args != null ? args[key] : null;
//   } catch (e) {
//     print(e);
//   }
//   return null;
// }
