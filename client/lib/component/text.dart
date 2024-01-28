import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';

/// LABEL TYPE
enum CustomTextStyle {
  caption, // 12.0
  normal, // 14.0
  medium, // 16.0
  large, // 18.0
  headline6, // 20.0
  headline5, // 24.0
}

class CustomText extends StatelessWidget {
  /// Main
  final String? text;
  final CustomTextStyle? style;

  /// Box constraint arguments
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;

  /// Text arguments
  final Color? color;
  final Color? bgColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? softWrap;
  final int? maxLines;
  final double? lineSpace;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontStyle fontStyle;
  final bool underlined;
  final Color? underlineColor;
  final BoxBorder? border;
  const CustomText(
    this.text, {
    super.key,
    this.style = CustomTextStyle.normal,
    this.margin = const EdgeInsets.all(0.0),
    this.padding = const EdgeInsets.all(0.0),
    this.alignment,
    this.color,
    this.bgColor,
    this.fontSize = 13,
    this.fontWeight,
    this.softWrap,
    this.maxLines,
    this.lineSpace,
    this.textAlign,
    this.overflow,
    this.fontStyle = FontStyle.normal,
    this.underlined = false,
    this.underlineColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      alignment: alignment ?? Alignment.centerLeft,
      decoration: BoxDecoration(
        border: border,
      ),
      child: Text(
        text ?? '',
        softWrap: softWrap ?? true,
        maxLines: maxLines ?? 1,
        textAlign: textAlign ?? TextAlign.start,
        overflow: overflow ?? TextOverflow.ellipsis,
        style: TextStyle(
          color: color ?? ConstantColors.black,
          fontSize: fontSize ?? _fontSize(),
          fontWeight: fontWeight ?? _fontWeight(),
          height: lineSpace,
          backgroundColor: bgColor,
          fontStyle: fontStyle,
          fontFamily: 'FireSans',
          decoration: underlined ? TextDecoration.underline : null,
          decorationColor: underlineColor ?? ConstantColors.black,
          decorationThickness: 1,
        ),
      ),
    );
  }

  double _fontSize() {
    return 16;
  }

  FontWeight _fontWeight() {
    switch (style) {
      default:
        return fontWeight ?? FontWeight.w500;
    }
  }
}
