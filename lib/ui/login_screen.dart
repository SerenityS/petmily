import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/ui/init_setting/init_setting_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            width: Get.width * 0.3,
            child: Image.asset("assets/images/logo.png"),
          ),
          LoginTextField(controller: _idController, hint: "ID"),
          LoginTextField(controller: _pwController, hint: "PW"),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () {
                  Get.off(() => InitSettingScreen());
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  LoginTextField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.pink.withOpacity(0.10),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.pink.withOpacity(0.10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          isDense: true,
          hintText: hint,
        ),
      ),
    );
  }
}
