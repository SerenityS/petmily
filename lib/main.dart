import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petmily/binding/dependency_binding.dart';
import 'package:petmily/service/secure_storage_service.dart';
import 'package:petmily/ui/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => SecureStorageService().init());
  [
    Permission.location,
    Permission.storage,
    Permission.bluetooth,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
  ].request().then((status) {
    initializeDateFormatting().then((_) => runApp(const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: DependencyBinding(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF8185E2),
        fontFamily: "SpoqaHanSansNeo",
        scaffoldBackgroundColor: const Color(0xFF8185E2),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
