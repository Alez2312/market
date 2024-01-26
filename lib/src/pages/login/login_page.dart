// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:market/src/pages/login/login_controller.dart';
import 'package:market/src/utils/main_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _controller = LoginController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circleLogin(),
            ),
            Positioned(top: 60, left: 6, child: _textLogin()),
            SingleChildScrollView(
              child: Column(
                children: [
                  _lottieAnimation(),
                  //_imageBanner(),
                  _textFiledEmail(),
                  _textFieldPassword(),
                  _buttonLogin(),
                  _textDontHaveAccount()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }

  _textLogin() {
    return const Text(
      "Iniciar Sesión",
      style: TextStyle(
          fontFamily: 'NimbusSans',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20),
    );
  }

  _imageBanner() {
    return Container(
      margin: EdgeInsets.only(
          top: 100, bottom: MediaQuery.of(context).size.height * 0.22),
      child: Image.asset(
        "assets/img/delivery.png",
        width: 200,
        height: 200,
      ),
    );
  }

  _lottieAnimation() {
    return Container(
      margin: EdgeInsets.only(
          top: 150, bottom: MediaQuery.of(context).size.height * 0.17),
      child: Lottie.asset("assets/json/delivery.json",
          width: 350, height: 200, fit: BoxFit.fill),
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

  _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _controller.login,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text("Ingresar"),
      ),
    );
  }

  _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿No tienes cuenta?",
          style: TextStyle(color: MyColors.primaryColor),
        ),
        const SizedBox(height: 7),
        GestureDetector(
          onTap: _controller.goToRegisterPage,
          child: Text(
            "Registrate",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor,
                fontSize: 18),
          ),
        )
      ],
    );
  }
}
