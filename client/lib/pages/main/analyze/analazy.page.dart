import 'dart:io';

import 'package:client/api/api_helper.dart';
import 'package:client/component/bottom_navigation.dart';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/component/text.dart';
import 'package:client/static/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AnalazyPage extends StatefulWidget {
  const AnalazyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnalazyPageState();
}

class _AnalazyPageState extends State<AnalazyPage> {
  File? pickedFile;
  ValueNotifier<String> aiGenerated = ValueNotifier<String>('');
  ValueNotifier<double> confidenceScore = ValueNotifier<double>(0.0);
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  Future<void> _pickImageFromGallery() async {
    print('--------------------------------');
    loading.value = true;
    final XFile? returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return;
    }
    setState(() {
      pickedFile = File(returnImage.path);
    });
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(pickedFile!.path, filename: 'image.jpg'),
      });
      final response = await Dio().post(
        '${ApiHelper.baseUrl}detect',
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        loading.value = false;
        final responseData = response.data;
        print('Response data: $responseData');
        setState(() {
          aiGenerated.value = responseData['class'];
          confidenceScore.value = responseData['confidence_score'];
        });
        print('ai ? ${aiGenerated.value}');
        print('confidenceScore ${confidenceScore.value}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      loading.value = false;
    }
  }

  String translatePrediction(String prediction) {
    if (prediction == 'Real') {
      return 'Энгийн зураг'; // Replace with your translated text for 'Real'
    } else if (prediction == 'Fake') {
      return 'Хиймэл оюун ухаан'; // Replace with your translated text for 'Fake'
    }
    return prediction; // Return the original value if not 'Real' or 'Fake'
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: const BottomNavigation(currentMenu: 2),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              translatePrediction(aiGenerated.value),
              color: Colors.white,
              textAlign: TextAlign.center,
              alignment: Alignment.center,
            ),
            CustomText(
              confidenceScore.value.toString(),
              color: Colors.white,
              textAlign: TextAlign.center,
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 50,
            ),
            if (pickedFile != null)
              Image.file(
                pickedFile!,
                width: 200,
              ),
            const SizedBox(
              height: 50,
            ),
            Button(
              loading: loading.value,
              onPressed: _pickImageFromGallery,
              text: 'Gallery',
              color: ConstantColors.primary.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
