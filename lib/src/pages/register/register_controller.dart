import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/src/models/response_api.dart';
import 'package:market/src/models/user.dart';
import 'package:market/src/providers/user_provider.dart';
import 'package:market/src/utils/my_snackbar.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UserProvider userProvider = UserProvider();
  Function? refresh;
  PickedFile? pickedFile;
  File? imageFile;
  late ProgressDialog _progressDialog;
  bool isEnabled = true;

  Future? init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    userProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
    return null;
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context!, "Debes ingresar todos los campos");
      return;
    }

    if (confirmPassword != password) {
      MySnackbar.show(context!, "Las contraseñas no coinciden");
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(
          context!, "La contraseña debe tener al menos 6 caracteres");
      return;
    }

    if (imageFile == null) {
      MySnackbar.show(context!, "Seleccione una imagen");
      return;
    }

    _progressDialog.show(max: 100, msg: 'Espere un momento...');
    isEnabled = false;

    User user = User(
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password: password,
    );

    Stream? stream = await userProvider.createWithImage(user, imageFile!);
    stream!.listen((res) {
      _progressDialog.close();
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print("Respuesta ${responseApi.toJson()}");
      MySnackbar.show(context!, responseApi.message!);

      if (responseApi.success == true) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context!, 'login');
        });
      } else {
        isEnabled = true;
      }
    });
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path); // XFile has a 'path' property
    }
    Navigator.pop(context!);
    refresh!();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: const Text('Galería'));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: const Text('Camára'));

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void back() {
    Navigator.pop(context!);
  }
}
