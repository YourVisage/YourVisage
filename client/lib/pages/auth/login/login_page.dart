import 'dart:io';

import 'package:client/api/firebase_auth.dart';
import 'package:client/bloc/authBloc.dart';
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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusNode _focusN = FocusNode();
  File? pickedFile;
  String? email;
  String? password = '';
  LoginUserResponse? loginjwt;
  @override
  void initState() {
    super.initState();
    setState(() {
      email = _emailController.text;
    });
  }

  Future<void> _blocListener(BuildContext context, AuthState state) async {
    if (state is LoginUserSuccess) {
      await Utils().showToastAlert(AppText.success, isAlert: false);
      Navkey.navkey.currentState?.pushNamed(RouterPath.camera, arguments: {
        'initialImage': pickedFile,
      });
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
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(_focusN);
              },
              child: Column(
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
                    focusNode: _focusNode,
                    controller: _emailController,
                    hintText: AppText.emailHint,
                    color: ConstantColors.white,
                    onFocusChanged: (p0) {},
                  ),
                  const SizedBox(height: 26),
                  Button(
                    loading: state is AuthLoading,
                    onPressed: () async {
                      if (_emailController.text.isNotEmpty) {
                        LoginUserRequest request = LoginUserRequest()..email = _emailController.text;
                        context.read<AuthBloc>().add(UserLoginEvent(request: request));
                      }
                    },
                    text: 'Нэвтрэх',
                  ),
                  const SizedBox(height: 26),
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
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
