import 'dart:convert';

import 'package:client/bloc/userBloc.dart';
import 'package:client/component/bottom_navigation.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/component/text.dart';
import 'package:client/helpers/application.dart';
import 'package:client/model/login_model.dart';
import 'package:client/model/userinfo_model.dart';
import 'package:client/provider/globals.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LoginUserResponse? login;
  UserinfoResponse? userInfo;
  String? profile;

  @override
  void initState() {
    login = globals.login;
    context.read<UserBloc>().add(GetUserInfoEvent(login?.accessToken ?? ''));
    _getSavedImageData();
    super.initState();
  }

  Future<void> _getSavedImageData() async {
    profile = await application.getProfileImage();
    setState(() {}); // Update state to trigger a rebuild
  }

  Future<void> _blocListener(BuildContext context, UserState state) async {
    if (state is GetUserInfoSuccess) {
      userInfo = state.res;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
        listener: _blocListener,
        builder: (context, state) {
          return CustomScaffold(
              scaffoldKey: _scaffoldKey,
              appBarColor: ConstantColors.primary,
              padding: EdgeInsets.zero,
              bottomNavigationBar: BottomNavigation(currentMenu: 3),
              drawer: Drawer(
                  backgroundColor: ConstantColors.black,
                  child: ListView(
                    padding: const EdgeInsets.only(top: kToolbarHeight),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: SvgPicture.asset(
                                Assets.close,
                                width: 16,
                                height: 16,
                                alignment: Alignment.topLeft,
                                color: ConstantColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navkey.navkey.currentState?.pushNamedAndRemoveUntil(RouterPath.login, (route) => false);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                Assets.close,
                                width: 16,
                                height: 16,
                                alignment: Alignment.topLeft,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                AppText.leave,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              body: Column(children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: ConstantColors.primary,
                      ),
                    ),
                    profile != null
                        ? Positioned(
                            top: 20,
                            left: 20,
                            child: ClipOval(
                              child: Container(
                                child: Image.memory(
                                  base64Decode(profile!),
                                  cacheHeight: 60,
                                  cacheWidth: 60,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          )
                        : Positioned(
                            top: 20,
                            left: 0,
                            child: Image.asset(
                              Assets.profile1,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Positioned(
                        bottom: 30,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomText(color: Colors.white, userInfo?.name ?? ''),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(color: ConstantColors.white),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(color: ConstantColors.white),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          profile != null
                              ? Container(
                                  width: 150,
                                  height: 200,
                                  decoration: BoxDecoration(color: ConstantColors.white),
                                  child: Image.memory(
                                    base64Decode(profile!),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: 150,
                                  height: 200,
                                  decoration: BoxDecoration(color: ConstantColors.white),
                                )
                        ],
                      ),
                    ],
                  ),
                )
              ]));
        });
  }
}
