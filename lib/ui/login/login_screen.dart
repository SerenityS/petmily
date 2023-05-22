import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/auth_controller.dart';
import 'package:petmily/ui/login/register_screen.dart';
import 'package:petmily/ui/login/widget/login_widget.dart';

class LoginScreen extends GetView<AuthController> {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Material(
              elevation: 8.0,
              shape: const CircleBorder(),
              child: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  radius: 60.0,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 75.0,
                  ))),
          const SizedBox(height: 15.0),
          LoginTextField(
            controller: _emailController,
            hint: "Email",
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email),
          ),
          LoginTextField(
            controller: _pwController,
            hint: "PW",
            isObscure: true,
            prefixIcon: const Icon(Icons.lock),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () async {
                  await controller.login(_emailController.text, _pwController.text);
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
          TextButton(
              onPressed: () {
                Get.to(() => RegisterScreen());
              },
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
        ]),
      ),
    );
  }
}
