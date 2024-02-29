import 'dart:io';

import 'package:client/bloc/deepFakeImage/fake_bloc.dart';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/helpers/utils.dart';
import 'package:client/model/image_picker_modal.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PickImagePage extends StatefulWidget {
  final File? initialImage;
  const PickImagePage({Key? key, this.initialImage}) : super(key: key);
  @override
  State createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
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

  Future<void> _pickImageFromCamera() async {
    await _pickImages(ImageSource.camera);
    SwapImageRequest request = SwapImageRequest()
      ..faceToSwap = widget.initialImage.toString()
      ..realImage = pickedFile.toString();

    context.read<FakeBloc>().add(FakeImageEvent(request: request));
  }

  Future<void> _pickImageFromGallery() async {
    await _pickImages(ImageSource.gallery);
    SwapImageRequest request = SwapImageRequest()
      ..faceToSwap = widget.initialImage.toString()
      ..realImage = pickedFile.toString();
    context.read<FakeBloc>().add(FakeImageEvent(request: request));
  }

  Future<void> _blocListener(BuildContext context, FakeState state) async {
    if (state is FakeImageSuccess) {
      Navkey.navkey.currentState?.pushNamed(
        RouterPath.generatedImage,
        arguments: {
          'initialImage': widget.initialImage,
          'targetImage': pickedFile,
        },
      );
    } else if (state is FakeImageFailure) {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FakeBloc, FakeState>(
        listener: _blocListener,
        builder: (context, state) {
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
                child: Column(
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
        });
  }
}
