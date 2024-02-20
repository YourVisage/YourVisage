import 'package:client/helpers/responsive_flutter.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BottomNavigation extends StatefulWidget {
  final int currentMenu;

  const BottomNavigation({Key? key, required this.currentMenu}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  double? _navBarItemWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double stdCutoutWidthDown = MediaQuery.of(context).viewPadding.bottom;
    return Container(
      padding: EdgeInsets.only(top: ResponsiveFlutter.of(context).hp(1), bottom: ResponsiveFlutter.of(context).hp(2)),
      margin: EdgeInsets.only(bottom: stdCutoutWidthDown >= 38 ? stdCutoutWidthDown : 0),
      height: ResponsiveFlutter.of(context).hp(8),
      width: double.maxFinite,
      decoration: BoxDecoration(border: const Border(top: BorderSide(color: ConstantColors.grey)), color: widget.currentMenu == 3 ? ConstantColors.black : ConstantColors.black),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _bottomNavItem(
              1,
              onTap: (() async {
                if (widget.currentMenu != 1) {
                  Navkey.navkey.currentState?.pushNamedAndRemoveUntil(RouterPath.homeMain, (route) => false);
                }

                setState(() {});
              }),
              asset: widget.currentMenu == 2 ? Assets.dashboard : Assets.dashboard,
            ),
          ),
          Expanded(
            child: _bottomNavItem(
              2,
              onTap: (() async {
                if (widget.currentMenu != 2) {
                  Navkey.navkey.currentState?.pushNamedAndRemoveUntil(RouterPath.analyze, (route) => false);
                }

                setState(() {});
              }),
              asset: widget.currentMenu == 3 ? Assets.analyze : Assets.analyze,
            ),
          ),
          Expanded(
            child: _bottomNavItem(
              3,
              onTap: (() async {
                if (widget.currentMenu != 3) {
                  Navkey.navkey.currentState?.pushNamedAndRemoveUntil(RouterPath.profile, (route) => false);
                }

                setState(() {});
              }),
              asset: widget.currentMenu == 1 ? Assets.person : Assets.person,
            ),
          ),
        ],
      ),
    );
  }

  _bottomNavItem(
    int index, {
    Function()? onTap,
    String asset = '',
  }) {
    _navBarItemWidth = _navBarItemWidth ?? (MediaQuery.of(context).size.width) / 5;

    return ZoomTapAnimation(
      end: 0.8,
      onTap: onTap!,
      beginDuration: const Duration(milliseconds: 50),
      endDuration: const Duration(milliseconds: 150),
      child: Container(
        width: _navBarItemWidth,
        color: ConstantColors.black,
        child: Center(
          child: index == 3
              ? SvgPicture.asset(
                  asset,
                  color: widget.currentMenu == index ? ConstantColors.primary : ConstantColors.grey,
                )
              : SvgPicture.asset(
                  asset,
                  color: widget.currentMenu == index ? ConstantColors.primary : ConstantColors.grey,
                ),
        ),
      ),
    );
  }
}
