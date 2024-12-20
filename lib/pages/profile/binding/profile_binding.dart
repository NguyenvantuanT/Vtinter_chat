import 'package:get/get.dart';
import 'package:vtinter_chat/pages/profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController());
  }
}