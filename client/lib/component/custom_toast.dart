import 'package:client/helpers/responsive_flutter.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class CustomToast extends StatelessWidget {
  final message;
  final bool? isAlert;
  final bool isConn;

  const CustomToast({
    super.key,
    this.message,
    this.isAlert,
    this.isConn = false,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
      child: GestureDetector(
          onTapDown: (va) {
            OverlaySupportEntry.of(context)?.dismiss();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.withOpacity(0.3),
            child: Column(children: [
              SizedBox(
                height: ResponsiveFlutter.of(context).hp(8),
              ),
              Container(
                width: 327,
                height: 80,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    color: ConstantColors.white,
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(
                        ResponsiveFlutter.of(context).fontSize(2))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: isAlert == false
                            ? ConstantColors.primary.withOpacity(0.8)
                            : ConstantColors.error.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        isAlert == true ? Icons.close_rounded : Icons.check,
                        size: 20,
                        color: ConstantColors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text('$message',
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: ConstantColors.black,
                            fontSize: 14,
                          )),
                    )
                  ],
                ),
              )
            ]),
          )),
    );
  }
}
