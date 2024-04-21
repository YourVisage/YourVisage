import 'dart:convert';
import 'dart:typed_data';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/helpers/application.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<void> saveImageData(String base64Image) async {
    final prefs = await application.getSharedPrefs();
    await prefs.setString('generated_image', base64Image);
  }

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
        child: Container(
            alignment: Alignment.center,
            child: widget.initialImage!.isNotEmpty
                ? Expanded(
                    flex: 1,
                    child: Image.memory(
                      imageData,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container()),
      ),
      floatingActionButton: Button(
        onPressed: () async {
          String base64image = base64Encode(imageData);
          await application.setGeneratedImage(base64image);
        },
        text: AppText.save,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
