import 'package:get/get.dart';
import 'package:vtinter_chat/components/app_tab_bar.dart';
import 'package:vtinter_chat/components/app_zoom_drawer.dart';
import 'package:vtinter_chat/pages/main/drawer/screen/drawer_page.dart';
import 'package:vtinter_chat/pages/main/home/screen/home_page.dart';
import 'package:vtinter_chat/pages/main_page_controller.dart';
import 'package:vtinter_chat/services/local/shared_prefs.dart';
import 'package:vtinter_chat/resource/themes/app_colors.dart';
import 'package:flutter/material.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppTabBar(
          leftPressed: controller.toggleDrawer,
          rightPressed: () {},
          title: "Home",
          avatar: SharedPrefs.user?.avatar ?? '',
        ),
        body: AppZoomDrawer(
          controller: controller.zoomDrawerController.value,
          menuScreen: const DrawerPage(),
          screen: const HomePage(),
        ),
      ),
    );
  }
}
