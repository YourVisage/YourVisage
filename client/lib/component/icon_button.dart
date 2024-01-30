import 'package:client/helpers/responsive_flutter.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconButton extends StatelessWidget {
  final double? width;
  final double? iconWidth;
  final double? iconHeight;
  final double? height;
  final Color? assetColor;
  final String assets;
  final VoidCallback onTap;
  final Color? color;
  const CustomIconButton(
      {super.key,
      this.width,
      this.height,
      required this.onTap,
      this.assetColor,
      this.color,
      required this.assets,
      this.iconWidth,
      this.iconHeight});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 40,
        height: height ?? 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: color ?? ConstantColors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(ResponsiveFlutter.of(context).fontSize(1.5)))),
        child: SvgPicture.asset(
          assets,
          height: iconHeight ?? 20,
          width: iconWidth ?? 20,
          fit: BoxFit.contain,
          color: assetColor ?? ConstantColors.primary,
        ),
      ),
    );
  }
}
