import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:client/api/firebase_auth.dart';
import 'package:client/component/text.dart';
import 'package:client/firebase_options.dart';
import 'package:client/pages/auth/login/login_page.dart';
import 'package:client/pages/main/home/home_page.dart';
import 'package:client/router/router.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // This widget is the root of your application.
  Widget _handleAuth() {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            //Show the login screen if the user is not logged in.
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
          } else {
            return HomePage();
          }
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(
                  FirebaseAuth.instance,
                  _googleSignIn,
                )),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null)
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
            home: _handleAuth()),
      ),
    );
  }
}
