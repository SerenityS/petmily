import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/const/petmily_const.dart';
import 'package:petmily/controller/auth_controller.dart';
import 'package:petmily/controller/petmily_controller.dart';
import 'package:petmily/data/model/pet.dart';
import 'package:petmily/data/provider/api_endpoint.dart';
import 'package:petmily/ui/main/screen/oss_screen.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final PetmilyController _petmilyController = Get.find<PetmilyController>();

  @override
  Widget build(BuildContext context) {
    Pet pet = _petmilyController.petList[0];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.20,
                  child: ClipRRect(
                      borderRadius: PetmilyConst.petmilyBorderRadius,
                      child: pet.imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: "${APIEndpoint.apiUrl}/petmily/image?file_name=${pet.imageUrl!}",
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                  child:
                                      SizedBox(width: 80, height: 80, child: CircularProgressIndicator(value: downloadProgress.progress))))
                          : Container(color: Colors.grey[100], child: Image.asset("assets/images/logo.png"))),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_authController.me!.nick, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(_authController.user!.email,
                        style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            SettingContainer(
              title: "계정 설정",
              iconData: Icons.person_outline,
              onTap: () => Get.to(() => const OssLicenceScreen()),
            ),
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: Colors.grey[300],
            ),
            SettingContainer(
              title: "반려동물 정보 수정",
              iconData: Icons.pets_outlined,
              onTap: () => Get.to(() => const OssLicenceScreen()),
            ),
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: Colors.grey[300],
            ),
            SettingContainer(
              title: "기기 / 계정 초기화",
              iconData: Icons.cancel_outlined,
              onTap: () => Get.to(() => const OssLicenceScreen()),
            ),
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: Colors.grey[300],
            ),
            SettingContainer(
              title: "오픈소스 라이선스",
              iconData: Icons.info_outline,
              onTap: () => Get.to(() => const OssLicenceScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingContainer extends StatelessWidget {
  const SettingContainer({super.key, required this.title, required this.iconData, required this.onTap});

  final String title;
  final IconData iconData;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(children: [
          Icon(iconData),
          const SizedBox(width: 20.0),
          Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }
}
