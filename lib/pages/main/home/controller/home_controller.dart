import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtinter_chat/components/app_dialog.dart';
import 'package:vtinter_chat/models/messager_model.dart';
import 'package:vtinter_chat/services/local/shared_prefs.dart';
import 'package:vtinter_chat/services/remote/mess_services.dart';

class HomeController extends GetxController {
  final messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  MessServices messServices = MessServices();
  FocusNode messFocus = FocusNode();

  void scrollScreen() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 100.0,
      duration: const Duration(milliseconds: 2600),
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
      ..avatar = SharedPrefs.user?.avatar
      ..createBy = SharedPrefs.user?.email
      ..id = '${DateTime.now().millisecondsSinceEpoch}'
      ..text = messageController.text.trim()
      ..isRecalled = false;
    scrollScreen();
    messServices.addMess(mess);
    messageController.clear();
  }
}
