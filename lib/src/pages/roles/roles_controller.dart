import 'package:flutter/material.dart';
import 'package:market/src/models/user.dart';
import 'package:market/src/utils/shared_pref.dart';

class RolesController {
  BuildContext? context;
  Function? refresh;
  User? user;
  SharedPref sharedPref = SharedPref();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    //Obteniendo el usuario que inició sesión.
    user = User.fromJson(await sharedPref.read('user'));
    refresh();
  }

  void goToPage(String route) {
    Navigator.pushNamedAndRemoveUntil(context!, route, (route) => false);
  }
}
