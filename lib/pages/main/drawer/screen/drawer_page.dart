import 'package:get/get.dart';
import 'package:vtinter_chat/components/app_dialog.dart';
import 'package:vtinter_chat/pages/main/drawer/controller/drawer_controller.dart';
import 'package:vtinter_chat/resource/themes/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../services/local/shared_prefs.dart';

class DrawerPage extends GetView<DrawerMainController> {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    const iconSize = 18.0;
    const iconColor = AppColor.orange;
    const spacer = 6.0;
    const textStyle = TextStyle(color: AppColor.brown, fontSize: 16.0);
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Welcome',
              style: TextStyle(color: AppColor.red, fontSize: 20.0)),
          Text(
            SharedPrefs.user?.name ?? '',
            style: const TextStyle(
                color: AppColor.brown,
                fontSize: 16.8,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 18.0),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: controller.navigaToProfile,
            child: const Row(
              children: [
                Icon(Icons.person, size: iconSize, color: iconColor),
                SizedBox(width: spacer),
                Text('My Profile', style: textStyle),
              ],
            ),
          ),
          const SizedBox(height: 18.0),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: controller.navigaToChangePass,
            child: const Row(
              children: [
                Icon(Icons.lock_outline, size: iconSize, color: iconColor),
                SizedBox(width: spacer),
                Text('Change Password', style: textStyle),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16.0, right: 20.0),
            height: 1.2,
            color: AppColor.grey,
          ),
          const Spacer(),
          InkWell(
            onTap: () => AppDialog.dialog(
              context,
              title: const Text('😍'),
              content: 'Do you want to logout?',
              action: () => controller.submitLogOut(context),
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: const Row(
              children: [
                Icon(Icons.logout, size: iconSize, color: iconColor),
                SizedBox(width: spacer),
                Text('Logout', style: textStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
