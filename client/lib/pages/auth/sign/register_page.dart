import 'dart:io';

import 'package:client/api/firebase_auth.dart';
import 'package:client/component/button.dart';
import 'package:client/component/custom_scaffold.dart';
import 'package:client/component/custum_text_input.dart';
import 'package:client/component/text.dart';
import 'package:client/helpers/utils.dart';
import 'package:client/static/app_text.dart';
import 'package:client/static/assets.dart';
import 'package:client/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  File? pickedFile;
  bool _isLoading = false;
  String? email = '';
  String? password = '';
  String? name = '';
  String? repassword = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      email = _emailController.text;
      password = _passwordController.text;
      name = _nameController.text;
      repassword = _repasswordController.text;
    });
  }

  Future<void> _pickImages(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });

    final XFile? returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    setState(() {
      pickedFile = File(returnImage.path);
      _isLoading = false;
    });
  }

  void _pickImageFromCamera() async {
    final result = await context.read<AuthenticationService>().signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          rePassword: _repasswordController.text.trim(),
          username: _nameController.text.trim(),
          initialImage: pickedFile,
        );
    if (result == 'Sign up') await _pickImages(ImageSource.gallery);
  }

  void _onButtonPressed() {
    if (validate()) {
      _pickImageFromCamera();
    } else {
      error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      padding: EdgeInsets.symmetric(horizontal: 33),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(Assets.logo),
          ),
          const SizedBox(
            height: 27,
          ),
          const CustomText(
            'Нэр',
            color: ConstantColors.grey,
          ),
          CustomTextInput(
            controller: _nameController,
            hintText: AppText.emailHint,
            color: ConstantColors.white,
          ),
          const SizedBox(
            height: 27,
          ),
          const CustomText(
            'email',
            color: ConstantColors.grey,
          ),
          CustomTextInput(
            controller: _emailController,
            hintText: AppText.emailHint,
            color: ConstantColors.white,
          ),
          const SizedBox(
            height: 17,
          ),
          const CustomText(
            'password',
            color: ConstantColors.grey,
          ),
          CustomTextInput(
            controller: _passwordController,
            hintText: 'password',
            color: ConstantColors.white,
          ),
          const SizedBox(
            height: 17,
          ),
          const CustomText(
            'repassword',
            color: ConstantColors.grey,
          ),
          CustomTextInput(
            controller: _repasswordController,
            hintText: AppText.emailHint,
            color: ConstantColors.white,
          ),
        ],
      ),
      floatingActionButton: _isLoading
          ? CircularProgressIndicator()
          : Container(
              margin: const EdgeInsets.all(20),
              child: Button(
                onPressed: _onButtonPressed,
                text: AppText.create,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _repasswordController.dispose();
    super.dispose();
  }

  validate() {
    if (_nameController.text.isEmpty && _nameController.text.length < 5) {
      return false;
    } else if (_emailController.text.isEmpty) {
      return false;
    } else if (_passwordController.text.isEmpty &&
        _repasswordController.text.isEmpty) {
      return false;
    } else if (_passwordController.text != _repasswordController.text) {
      return false;
    } else
      return true;
  }

  error() {
    if (_nameController.text.isEmpty || _nameController.text.length < 6) {
      Utils().showToastAlert('Нэрээ оруулна уу');
    } else if (_emailController.text.isEmpty) {
      Utils().showToastAlert('Мейл хаягаа оруулна уу');
    } else if (_passwordController.text.isEmpty ||
        _repasswordController.text.isEmpty) {
      Utils().showToastAlert('Нууц үгээ оруулна уу');
    } else if (_passwordController.text != _repasswordController.text) {
      Utils().showToastAlert('Нууц үгээ шалгана уу');
    }
  }
}