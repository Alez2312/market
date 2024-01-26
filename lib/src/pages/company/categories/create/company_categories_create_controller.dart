import 'package:flutter/material.dart';
import 'package:market/src/utils/my_snackbar.dart';

class CompanyCategoriesCreateController {
  BuildContext? context;
  Function? refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future? init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    return null;
  }

  void createCategory() {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context!, 'Debe ingresar todos los campos');
      return;
    }
    print('$name, $description');
  }
}
