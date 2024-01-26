import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:market/src/pages/register/register_controller.dart';
import 'package:market/src/utils/main_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _controller = RegisterController();
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
        body: SizedBox(
            width: double.infinity,
            child: Stack(children: [
              Positioned(top: -80, left: -100, child: _circle()),
              Positioned(top: 52, left: -5, child: _iconBack()),
              Positioned(top: 65, left: 33, child: _textRegister()),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 150),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _imageUser(),
                      const SizedBox(height: 30),
                      _textFiledEmail(),
                      _textFiledName(),
                      _textFiledLastName(),
                      _textFiledPhone(),
                      _textFieldPassword(),
                      _textFieldConfimPassword(),
                      _buttonRegister()
                    ],
                  ),
                ),
              )
            ])));
  }

  _circle() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }

  _iconBack() {
    return IconButton(
        onPressed: _controller.back,
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ));
  }

  _textRegister() {
    return const Text(
      "Registro",
      style: TextStyle(
          fontFamily: 'NimbusSans',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22),
    );
  }

  _imageUser() {
    return GestureDetector(
      onTap: _controller.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _controller.imageFile != null
            ? FileImage(_controller.imageFile!) as ImageProvider<Object>
            : const AssetImage("assets/img/user_profile_2.png"),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  _textFiledEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: "Correo Electrónico",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.email, color: MyColors.primaryColor),
            hintStyle: TextStyle(color: MyColors.primaryColorDark)),
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

  _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Contraseña",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.password, color: MyColors.primaryColor),
            hintStyle: TextStyle(color: MyColors.primaryColorDark)),
      ),
    );
  }

  _textFieldConfimPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Comfirmar contraseña",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            prefixIcon:
                Icon(Icons.password_outlined, color: MyColors.primaryColor),
            hintStyle: TextStyle(color: MyColors.primaryColorDark)),
      ),
    );
  }

  _buttonRegister() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _controller.isEnabled ? _controller.register : null,
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
