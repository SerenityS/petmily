import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/auth_controller.dart';
import 'package:petmily/ui/login/widget/login_widget.dart';

class RegisterScreen extends GetView<AuthController> {
  RegisterScreen({super.key});

  final TextEditingController _nickController = TextEditingController();
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
                    'assets/images/sign_up.png',
                    width: 75.0,
                  ))),
          const SizedBox(height: 15.0),
          LoginTextField(
            controller: _nickController,
            hint: "Nickname",
            prefixIcon: const Icon(Icons.person),
          ),
          LoginTextField(
            controller: _emailController,
            hint: "Email",
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email),
          ),
          LoginTextField(
            controller: _pwController,
            hint: "PW",
            prefixIcon: const Icon(Icons.lock),
            isObscure: true,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () async {
                  await controller.register(_emailController.text, _pwController.text, _nickController.text);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Register',
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
