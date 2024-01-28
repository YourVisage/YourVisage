import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  const CustomScaffold({
    Key? key,
    required this.body,
    this.padding,
    this.appBar,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: backgroundColor ?? ConstantColors.black,
        appBar: appBar ??
            emptyAppBar(
              context: context,
            ),
        body: Container(
          padding:
              padding ?? const EdgeInsets.only(left: 16, right: 16, bottom: 30),
          child: body,
        ),
      ),
    );
  }
}

PreferredSize emptyAppBar({
  required BuildContext context,
  Brightness brightness = Brightness.light,
  Color backgroundColor = Colors.white,
  double elevation = 0.0,
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(0.0), // here the desired height
    child: AppBar(
      backgroundColor: ConstantColors.black,
      leading: Container(),
      elevation: elevation,
      actions: const <Widget>[],
    ),
  );
}
