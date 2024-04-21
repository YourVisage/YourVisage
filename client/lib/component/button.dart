import 'package:client/component/text.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';

enum ButtonType { defaultButton, borderedButton, textButton }

class Button extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? borderWidth;
  final VoidCallback? onPressed;
  final ButtonType type;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final FontWeight? fontWeight;
  final BorderRadius? bRadius;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? disabledColor;
  final bool? loading;

  const Button({
    Key? key,
    this.text,
    this.color,
    required this.onPressed,
    this.borderWidth,
    this.type = ButtonType.defaultButton,
    this.margin,
    this.width,
    this.height,
    this.fontWeight,
    this.bRadius,
    this.fontSize,
    this.backgroundColor,
    this.disabledColor,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? _getButtonColor(),
        side: BorderSide(width: _getBorderWidth(), color: _getBorderColor()),
        elevation: 0,
        minimumSize: const Size.fromHeight(40),
        shape: RoundedRectangleBorder(borderRadius: bRadius ?? BorderRadius.circular(8)),
        disabledBackgroundColor: disabledColor ?? ConstantColors.white.withOpacity(0.5));
    return Container(
      padding: EdgeInsets.zero,
      margin: margin ?? const EdgeInsets.only(bottom: 10),
      width: width ?? 285,
      height: height ?? 50,
      child: ElevatedButton(onPressed: onPressed, style: style, child: _child()),
    );
  }

  Widget _child() {
    if (text != null) {
      return loading == true
          ? const CircularProgressIndicator(
              strokeWidth: 1,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : CustomText(
              text,
              color: _getTextColor(),
              alignment: Alignment.center,
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight ?? FontWeight.w500,
            );
    } else {
      return Container();
    }
  }

  Color _getButtonColor() {
    if (onPressed == null) {
      return (color ?? ConstantColors.primary.withOpacity(0.5));
    }
    switch (type) {
      case ButtonType.defaultButton:
        return color ?? ConstantColors.primary;
      case ButtonType.borderedButton:
        return ConstantColors.white; // You can customize this color for bordered buttons
      case ButtonType.textButton:
        return Colors.transparent; // You can customize this color for text buttons
    }
  }

  double _getBorderWidth() {
    return type == ButtonType.borderedButton ? (borderWidth ?? 0.5) : 0.0;
  }

  Color _getBorderColor() {
    return type == ButtonType.borderedButton ? (color ?? ConstantColors.grey) : Colors.transparent;
  }

  Color _getTextColor() {
    switch (type) {
      case ButtonType.defaultButton:
        return ConstantColors.white;
      case ButtonType.borderedButton:
        return ConstantColors.primary; // Customize this color for bordered buttons
      case ButtonType.textButton:
        return Colors.white; // Customize this color for text buttons
    }
  }
}
