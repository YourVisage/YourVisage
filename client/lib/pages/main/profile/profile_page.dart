import 'package:client/component/bottom_navigation.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/component/text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarColor: ConstantColors.primary,
      padding: EdgeInsets.zero,
      bottomNavigationBar: BottomNavigation(currentMenu: 3),
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
            Positioned(
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
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
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
              const CustomText(
                'UserName',
                color: Colors.white,
              ),
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
            ],
          ),
        )
      ]),
    );
  }
}
