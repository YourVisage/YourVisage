import 'dart:io';

import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';

class GeneratedImagePage extends StatefulWidget {
  final File? initialImage;
  final File? targetImage;
  const GeneratedImagePage({
    Key? key,
    this.initialImage,
    this.targetImage,
  }) : super(key: key);

  @override
  _GeneratedImagePageState createState() => _GeneratedImagePageState();
}

class _GeneratedImagePageState extends State<GeneratedImagePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: ConstantColors.black,
        leading: BackButton(
          color: ConstantColors.grey,
          onPressed: () => Navkey.navkey.currentState?.pop(),
        ),
        shape: const Border(
            bottom: BorderSide(
          color: ConstantColors.grey,
        )),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                if (widget.targetImage != null)
                  Image.file(widget.targetImage!, width: 200),
                SizedBox(
                  height: 20,
                ),
                if (widget.initialImage != null)
                  Image.file(widget.initialImage!, width: 200),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              child: Button(
                onPressed: () {},
                text: AppText.save,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
