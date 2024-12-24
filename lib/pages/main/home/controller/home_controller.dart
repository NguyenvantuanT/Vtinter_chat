import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtinter_chat/components/app_dialog.dart';
import 'package:vtinter_chat/models/messager_model.dart';
import 'package:vtinter_chat/services/local/get_storage_local.dart';
// import 'package:vtinter_chat/services/local/shared_prefs.dart';
import 'package:vtinter_chat/services/remote/mess_services.dart';

class HomeController extends GetxController {
  final messageController = TextEditingController();
  late ScrollController scrollController;
  MessServices messServices = MessServices();
  FocusNode messFocus = FocusNode();

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
  }

  void scrollScreen() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 100.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void delete(String? docId) {
    messServices.deleteMes(docId ?? "");
  }

  void editMess(BuildContext context, MessagerModel mess) {
    AppDialog.editMess(context, mess).then((value) {
      messServices.updateMess(value);
      messFocus.unfocus();
    });
  }

  void unRecallMess(MessagerModel mess) {
    messServices.updateMess(mess..isRecalled = false);
  }

  void reCall(MessagerModel mess) {
    messServices.updateMess(mess..isRecalled = true);
  }

  void sendMessage() {
    MessagerModel mess = MessagerModel()
      ..avatar = GetStorageLocal.user?.avatar
      ..createBy = GetStorageLocal.user?.email
      ..id = '${DateTime.now().millisecondsSinceEpoch}'
      ..text = messageController.text.trim()
      ..isRecalled = false;

    messageController.clear();
    messServices.addMess(mess);
    scrollScreen();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
