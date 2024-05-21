import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/helpers/application.dart';
import 'package:client/model/login_model.dart';
import 'package:client/provider/globals.dart';
import 'package:client/router/router_path.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/constant.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFrontCamera = false;
  XFile? _pickedFile;
  late List<CameraDescription> _cameras;
  LoginUserResponse? login;

  @override
  void initState() {
    super.initState();
    login = globals.login;
    _initializeCamera();
    print('jwt token shvv $login');
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _getCameraToUse(),
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize();
    setState(() {}); // Trigger a rebuild to start showing the FutureBuilder
  }

  CameraDescription _getCameraToUse() {
    return _isFrontCamera
        ? _cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front)
        : _cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
  }

  void _toggleCameraDirection() async {
    if (_controller != null) {
      await _controller!.dispose();
    }

    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });

    _controller = CameraController(
      _getCameraToUse(),
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize();
    setState(() {});
  }

  void _takePicture() async {
    try {
      await _initializeControllerFuture; // Ensure the controller is initialized before taking a picture
      if (_controller != null && _controller!.value.isInitialized) {
        final XFile file = await _controller!.takePicture();
        setState(() {
          _pickedFile = file;
        });
        print('filuud: ${_pickedFile?.path}');
        if (_pickedFile != null) {
          File imageFile = File(_pickedFile!.path);
          Navkey.navkey.currentState?.pushNamed(RouterPath.homeMain, arguments: {
            'initialImage': imageFile,
          });
          final bytes = await _pickedFile!.readAsBytes();
          await application.setProfileImage(base64Encode(bytes));
        }
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
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_controller != null && _controller!.value.isInitialized) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(0),
                child: CameraPreview(
                  _controller!,
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
                  ),
                ),
              );
            } else {
              return const Center(child: Text("Camera not initialized"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
