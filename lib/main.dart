import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vtinter_chat/firebase_options.dart';
import 'package:vtinter_chat/routes/app_routes.dart';
import 'package:vtinter_chat/services/local/get_storage_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
  // await SharedPrefs.initialise();
  await GetStorageLocal.initialise();
  runApp(const MainApp(initialRoute: PageName.splashPage));
}

class MainApp extends StatelessWidget {
  final String initialRoute;
  const MainApp({super.key, required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
      initialRoute: initialRoute,
    );
  }
}
