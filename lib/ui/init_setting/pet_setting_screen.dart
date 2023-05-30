import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petmily/const/petmily_const.dart';
import 'package:petmily/data/model/pet.dart';
import 'package:petmily/ui/init_setting/pet_specific_setting_screen.dart';
import 'package:petmily/ui/init_setting/widget/setting_widget.dart';

class PetSettingScreen extends StatefulWidget {
  const PetSettingScreen({super.key});

  @override
  PetSettingScreenState createState() => PetSettingScreenState();
}

class PetSettingScreenState extends State<PetSettingScreen> with SingleTickerProviderStateMixin {
  Pet pet = Get.arguments;

  final TextEditingController _nameTextController = TextEditingController();

  @override
  void dispose() {
    _nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    return Scaffold(
      backgroundColor: const Color(0xFF8185E2),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "사랑스러운 우리 아이를\n등록해주세요!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: color),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "이름",
                          style: TextStyle(color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SettingTextField(controller: _nameTextController, hint: "이름"),
                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "출생년도",
                          style: TextStyle(color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? newBirth = await showDatePicker(
                            context: context,
                            initialDate: pet.birth,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                            locale: const Locale('ko', 'KR'),
                          );
                          if (newBirth != null) {
                            setState(() {
                              pet.birth = newBirth;
                            });
                          }
                        },
                        child: Container(
                            width: double.infinity,
                            height: 65.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    DateFormat.yMMMd('ko_KR').format(pet.birth),
                                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                  )),
                            )),
                      ),
                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "성별",
                          style: TextStyle(color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          height: 65.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: DropdownButton(
                                  isExpanded: true,
                                  borderRadius: PetmilyConst.petmilyBorderRadius,
                                  value: pet.isMale,
                                  underline: const SizedBox.shrink(),
                                  items: const [
                                    DropdownMenuItem(
                                      value: true,
                                      child: Text(
                                        "남",
                                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: false,
                                      child: Text(
                                        "여",
                                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      pet.isMale = value;
                                    });
                                  },
                                )),
                          )),
                      const SizedBox(height: 40),
                      SizedBox(
                          width: double.infinity,
                          height: 65.0,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: PetmilyConst.petmilyBorderRadius,
                                ),
                              ),
                              onPressed: () {
                                if (_nameTextController.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "이름을 입력해주세요.");
                                } else {
                                  pet.name = _nameTextController.text;
                                  Get.to(() => const PetSpecificSettingScreen(), arguments: pet);
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "다음",
                                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                  Text(
                                    ">",
                                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ],
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
