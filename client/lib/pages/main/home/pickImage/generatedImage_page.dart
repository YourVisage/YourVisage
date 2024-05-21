import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/helpers/application.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

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
  Uint8List? imageData;
  @override
  void initState() {
    super.initState();
    imageData = base64Decode(widget.initialImage!.split(',').last);
  }

  Future<void> saveImageToGallery() async {
    final result = await ImageGallerySaver.saveImage(imageData!);
    if (result['isSuccess']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Зургийг галерейд хадгалсан'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Зургийг хадгалж чадсангүй'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // imageData = base64Decode(widget.initialImage!.split(',').last);
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: ConstantColors.black,
        leading: BackButton(
          color: ConstantColors.grey,
          onPressed: () => Navkey.navkey.currentState?.pushNamed(RouterPath.homeMain),
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
                      imageData!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container()),
      ),
      floatingActionButton: Button(
        onPressed: () async {
          saveImageToGallery();
          String base64image = base64Encode(imageData!);
          await application.setGeneratedImage(base64image);
        },
        text: AppText.save,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
