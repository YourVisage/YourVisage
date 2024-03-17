import 'dart:io';

import 'package:camera/camera.dart';
import 'package:client/bloc/userBloc.dart';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/helpers/application.dart';
import 'package:client/model/login_model.dart';
import 'package:client/provider/globals.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFrontCamera = false;
  late XFile? _pickedFile;
  late List<CameraDescription> _cameras;
  LoginUserResponse? login;

  @override
  void initState() {
    login = globals.login;
    _initializeCamera();
    super.initState();
    print('jwt token shvv $login');
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();

    _controller = CameraController(
      _getCameraToUse(),
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();

    _initializeControllerFuture.then((_) {
      setState(() {});
    });
  }

  CameraDescription _getCameraToUse() {
    if (_isFrontCamera) {
      return _cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    } else {
      return _cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    }
  }

  void _toggleCameraDirection() async {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    _controller = CameraController(
      _getCameraToUse(),
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    _initializeControllerFuture.then((_) {
      setState(() {});
    });
  }

  // Future<String> uploadImageToFirebase(File imageFile) async {
  //   String fileName = basename(imageFile.path);
  //   Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('${login?.accessToken}/$fileName');
  //   UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  //   String downloadURL = await taskSnapshot.ref.getDownloadURL();
  //   return downloadURL;
  // }

  void _takePicture() async {
    try {
      final XFile file = await _controller.takePicture();
      setState(() {
        _pickedFile = file;
      });
      print('filuud: ${_pickedFile?.path}');
      if (_pickedFile != null) {
        File imageFile = File(_pickedFile!.path);
        // String downloadURL = await uploadImageToFirebase(imageFile);
        // print('Image uploaded to Firebase Storage: $downloadURL');
        // await application.setProfileImage(imageFile.toString());
        Navkey.navkey.currentState?.pushNamed(RouterPath.homeMain, arguments: {
          'initialImage': imageFile,
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        floatingActionButton: Container(
          margin: const EdgeInsets.all(10),
          child: Button(
            onPressed: _takePicture,
            text: AppText.pickImage,
          ),
        ),
        body: !_controller.value.isInitialized
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(00),
                child: CameraPreview(_controller,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: _toggleCameraDirection,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Icon(
                            Icons.swap_vert_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
