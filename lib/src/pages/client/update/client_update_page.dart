import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:market/src/pages/client/update/client_update_controller.dart';
import 'package:market/src/utils/main_colors.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({super.key});

  @override
  State<ClientUpdatePage> createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {
  final ClientUpdateController _controller = ClientUpdateController();
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
        backgroundColor: MyColors.primaryColor,
        title: const Text('Editar perfil'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              _imageUser(),
              const SizedBox(height: 30),
              _textFiledName(),
              _textFiledLastName(),
              _textFiledPhone()
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttonUpdate(),
    );
  }

  _imageUser() {
    return GestureDetector(
      onTap: _controller.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _controller.imageFile != null
            ? FileImage(_controller.imageFile!) as ImageProvider<Object>
            : _controller.user?.image != null
                ? NetworkImage(_controller.user!.image!)
                    as ImageProvider<Object>
                : const AssetImage("assets/img/user_profile_2.png"),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
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
            hintText: "Nombre",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.person, color: MyColors.primaryColor),
            hintStyle: TextStyle(color: MyColors.primaryColorDark)),
      ),
    );
  }

  _textFiledLastName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.lastnameController,
        decoration: InputDecoration(
            hintText: "Apellidos",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            prefixIcon:
                Icon(Icons.person_outline, color: MyColors.primaryColor),
            hintStyle: TextStyle(color: MyColors.primaryColorDark)),
      ),
    );
  }

  _textFiledPhone() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: "Teléfono",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.phone, color: MyColors.primaryColor),
            hintStyle: TextStyle(color: MyColors.primaryColorDark)),
      ),
    );
  }

  _buttonUpdate() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _controller.isEnabled ? _controller.update : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text("Actualizar perfil"),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
