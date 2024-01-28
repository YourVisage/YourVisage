import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatefulWidget {
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Color? color;
  final bool obscureText;
  final bool autofocus;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final int? maxLines;
  final bool? enabled;
  final bool? isCapital;
  final double? height;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? labelText;
  final FocusNode? myFocus;
  final FocusNode? nextFocus;
  final Function(bool)? onFocusChanged;
  final String? text;
  final bool? clearText;
  final bool? inLongAddressController;
  final String? prefixAsset;
  final bool? readOnly;
  final double? width;
  final TextStyle? hintstyle;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final bool? hasBorder;
  final double? borderRadius;
  final bool? showCursor;

  const CustomTextInput({
    Key? key,
    this.labelStyle,
    this.inputFormatters,
    this.decoration,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.color,
    this.obscureText = false,
    this.autofocus = false,
    this.focusNode,
    this.onEditingComplete,
    this.maxLines,
    this.height,
    this.enabled = true,
    this.hintText,
    this.myFocus,
    this.onFocusChanged,
    this.nextFocus,
    this.text = '',
    this.clearText = false,
    this.inLongAddressController = false,
    this.prefixAsset,
    this.readOnly = false,
    this.isCapital = false,
    this.width,
    this.prefixIcon,
    this.hintstyle,
    this.padding,
    this.textStyle,
    this.labelText,
    this.backgroundColor,
    this.hasBorder = true,
    this.borderRadius,
    this.showCursor = true,
  }) : super(key: key);

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  FocusNode? _focusNode;

  bool _isObscure = false;

  late TextEditingController _controller;
  @override
  void initState() {
    _isObscure = widget.obscureText;

    _focusNode = widget.myFocus ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _focusNode!.addListener(() {
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged!(_focusNode!.hasFocus);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              height: widget.width ?? 54,
              width: widget.width ?? double.infinity,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? ConstantColors.white,
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
              ),
              child: TextField(
                showCursor: widget.showCursor,
                inputFormatters: widget.inputFormatters,
                textInputAction: widget.textInputAction,
                enabled: widget.enabled,
                textCapitalization: widget.isCapital ?? false
                    ? TextCapitalization.sentences
                    : TextCapitalization.none,
                maxLines: widget.maxLines,
                autofocus: widget.autofocus,
                focusNode: _focusNode,
                obscureText: _isObscure,
                controller: _controller,
                keyboardType: widget.keyboardType,
                onChanged: widget.onChanged,
                readOnly: widget.readOnly ?? false,
                cursorColor: ConstantColors.primary,
                onEditingComplete: () {
                  if (widget.nextFocus != null) {
                    FocusScope.of(context).requestFocus(widget.nextFocus);
                  } else {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
                style: widget.readOnly != true
                    ? _focusNode!.hasFocus
                        ? widget.textStyle ??
                            const TextStyle(color: ConstantColors.primary)
                        : widget.textStyle ??
                            const TextStyle(color: ConstantColors.primary)
                    : widget.textStyle ??
                        const TextStyle(color: ConstantColors.primary),
                decoration:
                    (widget.decoration ?? const InputDecoration()).copyWith(
                  filled: true,
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(
                          widget.prefixIcon,
                          color: ConstantColors.primary,
                          size: 20,
                        )
                      : null,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ConstantColors.grey, width: 1)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          color: ConstantColors.grey, width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ConstantColors.grey)),
                  errorBorder: InputBorder.none,
                  fillColor: ConstantColors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ConstantColors.primary, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ConstantColors.error, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  isDense: true,
                  counterText: '',
                  suffixIcon: _focusNode!.hasFocus
                      ? !widget.clearText! && !widget.obscureText
                          ? null
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: widget.clearText! ? 24 : 0),
                                    child: Row(
                                      children: [
                                        widget.obscureText
                                            ? InkWell(
                                                onTap: () {
                                                  _isObscure = !_isObscure;
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  !_isObscure
                                                      ? Icons
                                                          .visibility_outlined
                                                      : Icons
                                                          .visibility_off_outlined,
                                                  color: ConstantColors.primary,
                                                  size: 20,
                                                ),
                                              )
                                            : Container(),
                                        SizedBox(
                                            width: widget.clearText! ? 10 : 0),
                                        widget.clearText!
                                            ? InkWell(
                                                onTap: () {
                                                  widget.controller!.clear();
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: ConstantColors.primary,
                                                ),
                                              )
                                            : Container(
                                                color: Colors.purple,
                                              ),
                                      ],
                                    ),
                                  )
                                ])
                      : const SizedBox(width: 0),
                  contentPadding: widget.readOnly != true
                      ? const EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15)
                      : widget.labelText != null
                          ? const EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 20)
                          : const EdgeInsets.only(
                              left: 15, right: 15, top: 15, bottom: 15),
                  labelStyle: widget.labelStyle ??
                      const TextStyle(color: ConstantColors.grey),
                  hintStyle: widget.hintstyle ??
                      const TextStyle(color: ConstantColors.grey),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
