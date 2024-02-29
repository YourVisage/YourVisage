import 'dart:convert';
import 'dart:typed_data';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class GeneratedImagePage extends StatefulWidget {
  final String? initialImage;
  const GeneratedImagePage({
    Key? key,
    this.initialImage,
  }) : super(key: key);

  @override
  _GeneratedImagePageState createState() => _GeneratedImagePageState();
}

class _GeneratedImagePageState extends State<GeneratedImagePage> {
  @override
  Widget build(BuildContext context) {
    final imageData = base64Decode(widget.initialImage!.split(',').last);
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
            Column(children: [
              if (widget.initialImage!.isNotEmpty)
                Image.memory(
                  imageData,
                  fit: BoxFit.cover,
                  width: 200,
                ),
            ]),
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
