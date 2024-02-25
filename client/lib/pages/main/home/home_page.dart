import 'dart:io';

import 'package:client/component/bottom_navigation.dart';
import 'package:client/component/card.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/component/text.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final File? initialImage;
  const HomePage({Key? key, this.initialImage}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        padding: const EdgeInsets.only(left: 0, right: 0),
        bottomNavigationBar: const BottomNavigation(currentMenu: 1),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    'YourVisage Ai',
                    color: ConstantColors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                    child: Image.asset(Assets.profile1),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            GestureDetector(
              onTap: () {
                Navkey.navkey.currentState?.pushNamed(RouterPath.pickImage,
                    arguments: {'initialImage': widget.initialImage});
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment(0, 0.5),
                width: 221,
                height: 326,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xCCD8ECE8),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(47)),
                  image: DecorationImage(
                    image: AssetImage(Assets.homeButtonImage),
                    fit: BoxFit.fill,
                  ),
                ),
                child: CustomCard(
                  text: AppText.faceSwap,
                  onTap: () {
                    print('object');
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
