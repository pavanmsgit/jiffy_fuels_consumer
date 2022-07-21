import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/phone_auth_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/product_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/user_controller_old.dart';
import 'package:jiffy_fuels_consumer/firebase_options.dart';
import 'package:jiffy_fuels_consumer/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  Get.put(AuthController());
  Get.put(PhoneAuthController());
  Get.put(UserControllerOld());
  Get.put(ProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jiffy Consumer',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          )),
      home: const SplashScreen(),
    );
  }
}




