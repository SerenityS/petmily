import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petmily/const/petmily_const.dart';
import 'package:petmily/controller/petmily_controller.dart';
import 'package:petmily/data/model/pet.dart';
import 'package:petmily/data/provider/api_endpoint.dart';
import 'package:petmily/ui/init_setting/finish_setting_screen.dart';

class PetSpecificSettingScreen extends StatefulWidget {
  const PetSpecificSettingScreen({super.key});

  @override
  PetSpecificSettingScreenState createState() => PetSpecificSettingScreenState();
}

class PetSpecificSettingScreenState extends State<PetSpecificSettingScreen> with SingleTickerProviderStateMixin {
  Pet pet = Get.arguments;

  final TextEditingController _weightTextController = TextEditingController();
  final TextEditingController _feedKcalTextController = TextEditingController();

  @override
  void dispose() {
    _weightTextController.dispose();
    _feedKcalTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    return Scaffold(
      backgroundColor: const Color(0xFF8185E2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "${pet.name}의 정보를\n등록해주세요.",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: color),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "사진",
                          style: TextStyle(color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
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
                        child: pet.imageUrl != null
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                        imageUrl: "${APIEndpoint.apiUrl}/petmily/image?file_name=${pet.imageUrl!}",
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                            child: SizedBox(
                                                width: 80,
                                                height: 80,
                                                child: CircularProgressIndicator(value: downloadProgress.progress)))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlinedButton(
                                        onPressed: () async {
                                          final ImagePicker picker = ImagePicker();
                                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                          if (image != null) {
                                            String imageUrl = await Get.find<PetmilyController>().postPetImage(image.path, pet.chipId);
                                            imageUrl = jsonDecode(imageUrl)["image_url"].toString();

                                            setState(() {
                                              pet.imageUrl = imageUrl;
                                            });
                                          }
                                        },
                                        child: const Text(
                                          "사진 변경",
                                          style: TextStyle(fontSize: 18.0),
                                        )),
                                  )
                                ],
                              )
                            : Center(
                                child: SizedBox(
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "귀여운 ${pet.name}의 사진을 등록해주세요!",
                                            style: const TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                        OutlinedButton(
                                            onPressed: () async {
                                              final ImagePicker picker = ImagePicker();
                                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                              if (image != null) {
                                                String imageUrl = await Get.find<PetmilyController>().postPetImage(image.path, pet.chipId);
                                                imageUrl = jsonDecode(imageUrl)["image_url"].toString();

                                                setState(() {
                                                  pet.imageUrl = imageUrl;
                                                });
                                              }
                                            },
                                            child: const Text(
                                              "+ 사진 추가",
                                              style: TextStyle(fontSize: 18.0),
                                            ))
                                      ],
                                    ))),
                      ),
                      const SizedBox(height: 25.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "체중",
                          style: TextStyle(color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
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
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _weightTextController,
                                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(14, 14, 2, 14),
                                  hintText: "3.0",
                                ),
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const Text(
                              "Kg",
                              style: TextStyle(color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 11.0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "특성",
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
                                  borderRadius: PetmilyConst.petmilyBorderRadius,
                                  isExpanded: true,
                                  value: pet.petType - 1,
                                  underline: const SizedBox.shrink(),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 0,
                                      child: Text(
                                        "4개월 미만",
                                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text(
                                        "5개월 ~ 성견",
                                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text(
                                        "비중성화",
                                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 3,
                                      child: Text(
                                        "중성화",
                                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 4,
                                      child: Text(
                                        "과체중",
                                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 5,
                                      child: Text(
                                        "비만",
                                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      pet.petType = value + 1;
                                    });
                                  },
                                )),
                          )),
                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "사료 열량",
                          style: TextStyle(color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
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
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _feedKcalTextController,
                                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(14, 14, 2, 14),
                                  hintText: "5.0",
                                ),
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const Text(
                              "Kcal/g",
                              style: TextStyle(color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 11.0),
                          ],
                        ),
                      ),
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
                              onPressed: () async {
                                if (_weightTextController.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "체중를 입력해주세요.");
                                } else if (_feedKcalTextController.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "사료 열량을 입력해주세요.");
                                } else {
                                  pet.weight = double.parse(_weightTextController.text);
                                  pet.feedKcal = double.parse(_feedKcalTextController.text);

                                  try {
                                    await Get.find<PetmilyController>().postPet(pet).then((value) {
                                      Get.find<PetmilyController>().petList.assign(pet);
                                      Get.offAll(() => const FinishSettingScreen());
                                    });
                                  } catch (e) {
                                    debugPrint("Register Pet Failed: $e");
                                  }
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "등록완료",
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
