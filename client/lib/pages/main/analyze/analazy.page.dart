import 'package:client/component/bottom_navigation.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:flutter/material.dart';

class AnalazyPage extends StatefulWidget {
  const AnalazyPage({Key? key}) : super(key: key);

  @override
  State createState() => _AnalazyPageState();
}

class _AnalazyPageState extends State<AnalazyPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(),
      bottomNavigationBar: const BottomNavigation(currentMenu: 2),
    );
  }
}
