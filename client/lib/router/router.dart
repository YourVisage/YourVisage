import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:client/component/text.dart';
import 'package:client/pages/auth/login/login_page.dart';
import 'package:client/pages/auth/sign/camera_page.dart';
import 'package:client/pages/auth/sign/register_page.dart';
import 'package:client/pages/main/analyze/analazy.page.dart';
import 'package:client/pages/main/home/home_page.dart';
import 'package:client/pages/main/home/pickImage/generatedImage_page.dart';
import 'package:client/pages/main/home/pickImage/pick_image_page.dart';
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
    Map<dynamic, dynamic>? args;
    if (settings.arguments != null) args = settings.arguments;
    switch (settings.name) {
      case RouterPath.login:
        return PageTransition(
            child: const LoginPage(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300));
      case RouterPath.home:
        return SwipeablePageRoute(
          builder: (_) => HomePage(),
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
          child: HomePage(
            initialImage: _getValueByKey(args, 'initialImage'),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case RouterPath.pickImage:
        return PageTransition(
          child: PickImagePage(
            initialImage: _getValueByKey(args, 'initialImage'),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
        );
      case RouterPath.generatedImage:
        return PageTransition(
          child: GeneratedImagePage(
            initialImage: _getValueByKey(args, 'initialImage'),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
        );
      case RouterPath.analyze:
        return PageTransition(
          child: AnalazyPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
        );
      case RouterPath.register:
        return SwipeablePageRoute(
          builder: (context) {
            return RegisterPage();
          },
          settings: settings,
          transitionDuration: const Duration(milliseconds: 200),
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

_getValueByKey(Map<dynamic, dynamic>? args, String key) {
  try {
    return args != null ? args[key] : null;
  } catch (e) {
    print(e);
  }
  return null;
}
