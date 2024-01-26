import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/src/models/response_api.dart';
import 'package:market/src/models/user.dart';
import 'package:market/src/providers/user_provider.dart';
import 'package:market/src/utils/my_snackbar.dart';
import 'package:market/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientUpdateController {
  BuildContext? context;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UserProvider userProvider = UserProvider();
  Function? refresh;
  PickedFile? pickedFile;
  File? imageFile;
  late ProgressDialog _progressDialog;
  bool isEnabled = true;

  User? user;
  final SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    userProvider.init(context, sessionUser: user);

    nameController.text = user!.name!;
    lastnameController.text = user!.lastname!;
    phoneController.text = user!.phone!;
    refresh();
  }

  void update() async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();

    if (name.isEmpty || lastname.isEmpty || phone.isEmpty) {
      MySnackbar.show(context!, "Debes ingresar todos los campos");
      return;
    }

    _progressDialog.show(max: 100, msg: 'Espere un momento...');
    isEnabled = false;

    User userUpdate = User(
        id: user!.id,
        name: name,
        lastname: lastname,
        phone: phone,
        image: user!.image);

    Stream? stream;
    if (imageFile != null) {
      stream = await userProvider.update(userUpdate, imageFile!);
    } else {
      stream = await userProvider.update(userUpdate, null);
    }

    stream?.listen((res) async {
      _progressDialog.close();
      dynamic decodedRes;
      try {
        decodedRes = json.decode(res);
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error de formato: $e');
        isEnabled = true;
        return;
      }

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message!);

      if (responseApi.success == true) {
        user = await userProvider.findByUserId(
            userUpdate.id!); // Obteniendo el usuario de la base de datos
        _sharedPref.save('user', user!.toJson());
        Navigator.pushNamedAndRemoveUntil(
            context!, 'client/products/list', (route) => false);
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
