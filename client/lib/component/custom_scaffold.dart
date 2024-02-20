import 'package:client/helpers/utils.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final String? imageBackground;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? drawer;
  final Color? appBarColor;

  const CustomScaffold({
    Key? key,
    required this.body,
    this.padding,
    this.appBar,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.imageBackground,
    this.scaffoldKey,
    this.drawer,
    this.appBarColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: backgroundColor ?? ConstantColors.black,
      appBar: appBar ??
          emptyAppBar(
            context: context,
            backgroundColor: appBarColor ?? ConstantColors.black,
          ),
      drawer: drawer,
      body: GestureDetector(
        onTap: () {
          Utils.hideKeyboard(context);
        },
        child: Container(
          padding: padding ?? const EdgeInsets.only(left: 16, right: 16, bottom: 30),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

PreferredSize emptyAppBar({
  required BuildContext context,
  Brightness brightness = Brightness.light,
  Color backgroundColor = ConstantColors.white,
  double elevation = 0.0,
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(0.0), // here the desired height
    child: AppBar(
      backgroundColor: backgroundColor,
      leading: Container(),
      elevation: elevation,
      actions: const <Widget>[],
    ),
  );
}
