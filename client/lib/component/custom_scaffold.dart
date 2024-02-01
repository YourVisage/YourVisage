import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final String? imageBackground;

  const CustomScaffold({
    Key? key,
    required this.body,
    this.padding,
    this.appBar,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.imageBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: backgroundColor ?? ConstantColors.black,
        appBar: appBar ?? emptyAppBar(context: context),
        body: Container(
          decoration: imageBackground != null
              ? BoxDecoration(
                  color: ConstantColors.lightBlue.withOpacity(0.2),
                  image: DecorationImage(
                      image: AssetImage(
                        imageBackground!,
                      ),
                      fit: BoxFit.fitHeight,
                      opacity: 0.7),
                )
              : null,
          padding: padding ?? const EdgeInsets.only(left: 16, right: 16, bottom: 30),
          child: body,
        ),
        bottomNavigationBar: bottomNavigationBar,
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
    preferredSize: Size.fromHeight(0.0),
    child: AppBar(
      backgroundColor: ConstantColors.black,
      leading: Container(),
      elevation: elevation,
      actions: const <Widget>[],
    ),
  );
}
