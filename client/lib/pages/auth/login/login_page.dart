import 'dart:io';

import 'package:client/api/firebase_auth.dart';
import 'package:client/bloc/userBloc.dart';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/component/custum_text_input.dart';
import 'package:client/component/text.dart';
import 'package:client/helpers/utils.dart';
import 'package:client/model/login_model.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? pickedFile;
  bool _isLoading = false;
  String? email;
  String? password = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      email = _emailController.text;
      password = _passwordController.text;
    });
  }

  Future<void> _pickImages(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });

    final XFile? returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    setState(() {
      pickedFile = File(returnImage.path);
      _isLoading = false;
    });
  }

  Future<void> _pickImageFromCamera() async {
    await context.read<AuthenticationService>().signIn(
          email: _emailController.text.toString().trim(),
          password: _passwordController.text.toString().trim(),
        );
  }

  Future<void> _blocListener(BuildContext context, AuthState state) async {
    if (state is LoginUserSuccess) {
      await Utils().showToastAlert(AppText.success, isAlert: false);
      await _pickImages(ImageSource.gallery);
      Navkey.navkey.currentState?.pushNamed(
        RouterPath.homeMain,
        arguments: {
          'initialImage': pickedFile,
        },
      );
    } else if (state is LoginUserFailed) {
      await Utils().showToastAlert(state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: _blocListener,
        builder: (context, state) {
          return CustomScaffold(
            padding: EdgeInsets.symmetric(horizontal: 33),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(Assets.logo),
                ),
                const SizedBox(
                  height: 27,
                ),
                const CustomText(
                  'email',
                  color: ConstantColors.grey,
                ),
                CustomTextInput(
                  controller: _emailController,
                  hintText: AppText.emailHint,
                  color: ConstantColors.white,
                ),
                // const SizedBox(
                //   height: 17,
                // ),
                // const CustomText(
                //   'password',
                //   color: ConstantColors.grey,
                // ),
                // CustomTextInput(
                //   controller: _passwordController,
                //   hintText: 'password',
                //   color: ConstantColors.white,
                // ),
                const SizedBox(height: 26),
                Button(
                  onPressed: () {
                    if (_emailController.text.isNotEmpty) {
                      LoginUserRequest request = LoginUserRequest()..email = _emailController.text;
                      // ..password = _passwordController.text;
                      context.read<AuthBloc>().add(UserLoginEvent(request: request));
                    }
                  },
                  text: 'Login',
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.84,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    const CustomText(
                      'Or With',
                      color: ConstantColors.grey,
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    Container(
                      width: 80.84,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => context.read<AuthenticationService>().signInWithGoogle(),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0xFFCDD1E0)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Image.asset(Assets.googlePng),
                        ),
                      ),
                      SizedBox(
                        width: 21,
                      ),
                      GestureDetector(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0xFFCDD1E0)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Icon(
                            Icons.facebook,
                            color: Colors.blue,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navkey.navkey.currentState?.pushNamed(RouterPath.register);
                  },
                  child: const CustomText(
                    AppText.create,
                    color: ConstantColors.grey,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                _isLoading ? CircularProgressIndicator() : Container(),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
