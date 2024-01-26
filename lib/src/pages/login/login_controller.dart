import 'package:flutter/material.dart';
import 'package:market/src/models/response_api.dart';
import 'package:market/src/models/user.dart';
import 'package:market/src/providers/user_provider.dart';
import 'package:market/src/utils/my_snackbar.dart';
import 'package:market/src/utils/shared_pref.dart';

class LoginController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserProvider userProvider = UserProvider();
  final SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context) async {
    this.context = context;
    await userProvider.init(context);
    User user = User.fromJson(await _sharedPref.read('user') ?? {});
    if (user.sessionToken != null) {
      if (user.roles!.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles![0].route, (route) => false);
      }
    }
    return null;
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, "register");
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await userProvider.login(email, password);
    print("Respuesta: ${responseApi.toJson()}");

    if (responseApi.success == true) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());

      if (user.roles!.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context!, user.roles![0].route, (route) => false);
      }
    } else {
      MySnackbar.show(context!, responseApi.message!);
    }
  }
}
