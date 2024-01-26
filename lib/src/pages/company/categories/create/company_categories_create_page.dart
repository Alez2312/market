import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:market/src/pages/company/categories/create/company_categories_create_controller.dart';
import 'package:market/src/utils/main_colors.dart';

class CompanyCategoriesCreatePage extends StatefulWidget {
  const CompanyCategoriesCreatePage({super.key});

  @override
  State<CompanyCategoriesCreatePage> createState() =>
      _CompanyCategoriesCreatePageState();
}

class _CompanyCategoriesCreatePageState
    extends State<CompanyCategoriesCreatePage> {
  final CompanyCategoriesCreateController _controller =
      CompanyCategoriesCreateController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CompanyCategoriesCreate'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          _textFiledName(),
          _textFiledDescription()
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  _textFiledName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.nameController,
        decoration: InputDecoration(
            hintText: "Nombre de la Categoría",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            suffixIcon: Icon(Icons.list_alt, color: MyColors.primaryColor),
            hintStyle: TextStyle(color: MyColors.primaryColorDark)),
      ),
    );
  }

  _textFiledDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.descriptionController,
        maxLines: 3,
        maxLength: 255,
        decoration: InputDecoration(
            hintText: "Descripciónde la Categoría",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            suffixIcon: Icon(Icons.description, color: MyColors.primaryColor),
            hintStyle: TextStyle(color: MyColors.primaryColorDark)),
      ),
    );
  }

  _buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _controller.createCategory,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text("Ingresar"),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
