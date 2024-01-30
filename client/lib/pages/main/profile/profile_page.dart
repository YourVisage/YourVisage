import 'package:client/component/bottom_navigation.dart';
import 'package:client/component/custom_scaffold.dart';
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
      body: Container(),
      bottomNavigationBar: const BottomNavigation(currentMenu: 2),
    );
  }
}
