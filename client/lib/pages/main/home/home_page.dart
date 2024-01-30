import 'package:client/component/bottom_navigation.dart';
import 'package:client/component/card.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/component/text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = [
    Assets.exampleImage,
    Assets.exampleImage,
    Assets.exampleImage,
    Assets.exampleImage,
    Assets.exampleImage,
  ];
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
              height: 31,
            ),
            Container(
                height: 143,
                padding: const EdgeInsets.only(left: 16),
                alignment: Alignment.topLeft,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(right: 21),
                        alignment: Alignment.topLeft,
                        child: CustomCard(image: images[index]),
                      );
                    }))
          ],
        ));
  }
}
