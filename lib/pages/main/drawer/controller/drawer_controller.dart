import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vtinter_chat/routes/app_routes.dart';
import 'package:vtinter_chat/services/local/shared_prefs.dart';

class DrawerMainController extends GetxController {


  Future<void> submitLogOut(context) async {
    await FirebaseAuth.instance.signOut();
    await SharedPrefs.removeSeason();
    if (!context.mounted) return;
    Get.offNamed(PageName.loginPage);
  }
}
