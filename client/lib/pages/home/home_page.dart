import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Container(
      alignment: Alignment.center,
      child: Button(
        onPressed: () {
          Navkey.navkey.currentState
              ?.pushNamedAndRemoveUntil(RouterPath.login, (route) => false);
        },
        text: 'Log out',
      ),
    ));
  }
}
