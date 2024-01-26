import 'package:flutter/material.dart';
import 'package:market/src/models/user.dart';
import 'package:market/src/utils/shared_pref.dart';

class DeliveryOrdersListController {
  BuildContext? context;
  final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  logout() {
    _sharedPref.logout(context!, user!.id!);
  }

  //Otra solución para el error: Null check operator used on a null value:
  /**
   *   logout() {
    if (context != null) {
      _sharedPref.logout(context!);
    } else {
      // Manejar el caso cuando context es nulo, por ejemplo, mostrando un mensaje de error.
    }
  }

   */

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
  }
}
