import 'dart:convert';
import 'dart:io';

import 'package:client/component/bottom_navigation.dart';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/component/text.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AnalazyPage extends StatefulWidget {
  const AnalazyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnalazyPageState();
}

class _AnalazyPageState extends State<AnalazyPage> {
  File? pickedFile;
  double? aiGenerated; // Declare aiGenerated variable here
  void initState() {
    super.initState();
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) {
      return;
    }

    setState(() {
      pickedFile = File(returnImage.path);
    });

    final uri = Uri.parse('http://10.0.2.2:8000/api/detect');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', pickedFile!.path));

    try {
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        // Successful response
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        setState(() {
          aiGenerated = responseData['type']
              ['ai_generated']; // Assign value to aiGenerated
        });
      } else {
        // Handle non-200 status code
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error occurred: $e');
    }
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
              aiGenerated != null ? 'AI Generated: $aiGenerated' : '',
              color: Colors.white,
              textAlign: TextAlign.center,
              alignment: Alignment.center,
            ),
            CustomText(
              aiGenerated != null
                  ? aiGenerated! < 0.5
                      ? 'Энгийн зураг байна'
                      : 'Хиймэл оюун ухааны зураг'
                  : '',
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
