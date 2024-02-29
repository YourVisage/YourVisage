import 'dart:io';

import 'package:client/bloc/deepFakeImage/fake_bloc.dart';
import 'package:client/component/bottom_navigation.dart';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/model/fake_detect_model.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AnalazyPage extends StatefulWidget {
  const AnalazyPage({Key? key}) : super(key: key);

  @override
  State createState() => _AnalazyPageState();
}

class _AnalazyPageState extends State<AnalazyPage> {
  File? pickedFile;
  Future<void> _pickImages(ImageSource source) async {
    final XFile? returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage == null) {
      return;
    }

    setState(() {
      pickedFile = File(returnImage.path);
    });
  }

  Future<void> _pickImageFromGallery() async {
    await _pickImages(ImageSource.gallery);
    DetectModelRequest res = DetectModelRequest()..uri = pickedFile.toString();
    context.read<FakeBloc>().add(DetectImageEvent(request: res));
  }

  Future<void> _blocListener(BuildContext context, FakeState state) async {
    if (state is DetectImageSuccess) {
      print('success');
    } else if (state is DetectImageFailure) {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FakeBloc, FakeState>(
        listener: _blocListener,
        builder: (context, state) {
          return CustomScaffold(
            bottomNavigationBar: const BottomNavigation(currentMenu: 2),
            body: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                      onPressed: () => _pickImageFromGallery(),
                      text: 'Gallery',
                      color: ConstantColors.primary.withOpacity(0.8),
                    ),
                  ],
                )),
          );
        });
  }
}
