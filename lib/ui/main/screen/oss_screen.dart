import 'package:flutter/material.dart';
import 'package:petmily/const/petmily_const.dart';
import 'package:petmily/oss_licenses.dart';

class OssLicenceScreen extends StatelessWidget {
  const OssLicenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("오픈소스 라이선스"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: ossLicenses.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: PetmilyConst.petmilyBorderRadius),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ossLicenses[i].name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(ossLicenses[i].license!),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
