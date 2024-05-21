import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:client/api/api_helper.dart';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/component/text.dart';
import 'package:client/helpers/application.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PickImagePage extends StatefulWidget {
  final File? initialImage;
  const PickImagePage({Key? key, this.initialImage}) : super(key: key);
  @override
  State createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  File? pickedFile;
  File? resultImage;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  String _returnImage = '';
  String pickedImages = '';
  Uint8List? pickedimage;
  File? tempFile;

  Future<void> _pickImages(ImageSource source) async {
    pickedImages = await application.getProfileImage();
    pickedimage = base64Decode(pickedImages!.split(',').last);
    final XFile? returnImage = await ImagePicker().pickImage(source: source);
    tempFile = await _writeBytesToTempFile(pickedimage!);

    if (returnImage == null) {
      return;
    }

    setState(() {
      pickedFile = File(returnImage.path);
    });
  }

  Future<File> _writeBytesToTempFile(Uint8List bytes) async {
    // Get the temporary directory on the device
    Directory tempDir = await getTemporaryDirectory();

    // Create a temporary file path
    String tempFilePath = '${tempDir.path}/temp_image.jpg';

    // Write the bytes to the temporary file
    File tempFile = File(tempFilePath);
    await tempFile.writeAsBytes(bytes);

    return tempFile;
  }

  Future<void> _pickImageFromCamera() async {
    await _pickImages(ImageSource.camera);
    isLoading.value = true;

    try {
      final dio = Dio();
      final formData = FormData.fromMap({
        'face_to_swap': await MultipartFile.fromFile(tempFile!.path),
        'real_image': await MultipartFile.fromFile(pickedFile!.path),
      });
      final response = await dio.post(
        '${ApiHelper.baseUrl}api/swap-image',
        data: formData,
      );
      print('response: ${response}');

      if (response.statusCode == 200) {
        print('--------------------------------');

        final responseData = response.data;

        _returnImage = 'data:image/png;base64,' + responseData['result_image'];
        await application.setGeneratedImage(_returnImage);
        isLoading.value = false;
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

  Future<void> _pickImageFromGallery() async {
    await _pickImages(ImageSource.gallery);
    isLoading.value = true;

    try {
      final dio = Dio();
      final formData = FormData.fromMap({
        'face_to_swap': await MultipartFile.fromFile(tempFile!.path),
        'real_image': await MultipartFile.fromFile(pickedFile!.path),
      });
      final response = await dio.post(
        '${ApiHelper.baseUrl}api/swap-image',
        data: formData,
      );
      print('response: ${response}');

      if (response.statusCode == 200) {
        print('--------------------------------');

        final responseData = response.data;

        _returnImage = 'data:image/png;base64,' + responseData['result_image'];
        await application.setGeneratedImage(_returnImage);
        isLoading.value = false;
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
          child: isLoading.value
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
                      loading: isLoading.value,
                      onPressed: () => _pickImageFromCamera(),
                      text: 'Camera',
                      color: ConstantColors.primary.withOpacity(0.8),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Button(
                      loading: isLoading.value,
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
