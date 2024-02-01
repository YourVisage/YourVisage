import 'package:client/component/text.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String? text;
  final void Function()? onTap;

  const CustomCard({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.transparent,
        child: Container(
          width: 201,
          height: 306,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              width: 201,
              height: 292,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xCCD8ECE8)),
                  borderRadius: BorderRadius.circular(47),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 201,
                    height: 292,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xCCD8ECE8)),
                        borderRadius: BorderRadius.circular(47),
                      ),
                    ),
                    child: text != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 25, left: 14),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                CustomText(
                                  text,
                                  alignment: Alignment.topLeft,
                                  color: ConstantColors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: ConstantColors.white,
                                      size: 15,
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          )
                        : Container()),
              ),
            ),
          ),
        ));
  }
}
