import 'dart:io';

import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/component/text.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImagePage extends StatefulWidget {
  final File? initialImage;
  const PickImagePage({Key? key, this.initialImage}) : super(key: key);
  @override
  State createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  File? pickedFile;
  File? resultImage;
  bool isLoading = false;
  String _returnImage = '';
  Future<void> _pickImages(ImageSource source) async {
    final XFile? returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage == null) {
      return;
    }

    setState(() {
      pickedFile = File(returnImage.path);
    });
  }

  Future<void> _pickImageFromCamera() async {
    await _pickImages(ImageSource.camera);
  }

  Future<void> _pickImageFromGallery() async {
    await _pickImages(ImageSource.gallery);
    setState(() {
      isLoading = true; // Start showing the loader
    });

    try {
      final dio = Dio();
      final formData = FormData.fromMap({
        'face_to_swap': await MultipartFile.fromFile(widget.initialImage!.path),
        'real_image': await MultipartFile.fromFile(pickedFile!.path),
      });
      final response = await dio.post(
        // 'http://10.0.2.2:8000/api/swap-image',
        'http://172.20.10.4:8000/api/swap-image',
        data: formData,
      );

      print('response: ${response}');

      if (response.statusCode == 200) {
        print('--------------------------------');

        final responseData = response.data;

        _returnImage = 'data:image/png;base64,' + responseData['result_image'];
        print('sadasd: $_returnImage');
        setState(() {
          isLoading = false; // Hide the loader
        });
        Navkey.navkey.currentState?.pushNamed(
          RouterPath.generatedImage,
          arguments: {
            'initialImage': _returnImage,
          },
        );
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      imageBackground: Assets.pickImagePic,
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
          alignment: Alignment.bottomCenter,
          child: isLoading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    CustomText(
                      AppText.please_wait,
                      color: Colors.white,
                      alignment: Alignment.center,
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                      onPressed: () => _pickImageFromCamera(),
                      text: 'Camera',
                      color: ConstantColors.primary.withOpacity(0.8),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Button(
                      onPressed: () => _pickImageFromGallery(),
                      text: 'Gallery',
                      color: ConstantColors.primary.withOpacity(0.8),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                )),
    );
  }
}
