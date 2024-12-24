import 'dart:async';

import 'package:get/get.dart';
import 'package:vtinter_chat/models/messager_model.dart';
import 'package:vtinter_chat/pages/main/home/controller/home_controller.dart';
import 'package:vtinter_chat/pages/main/home/widgets/messages_group.dart';
import 'package:vtinter_chat/services/local/get_storage_local.dart';
// import 'package:vtinter_chat/services/local/shared_prefs.dart';
import 'package:vtinter_chat/resource/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> messStream = FirebaseFirestore.instance
        .collection('database')
        .orderBy('id', descending: true)
        .snapshots();
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                List<MessagerModel> messagers = snapshot.data?.docs
                        .map((e) => MessagerModel.toJson(
                            e.data() as Map<String, dynamic>)
                          ..docId = e.id)
                        .toList() ??
                    [];
                return SlidableAutoCloseBehavior(
                  child: ListView.separated(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0)
                        .copyWith(top: 16.0, bottom: 20.0),
                    itemCount: messagers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                    itemBuilder: (context, index) {
                      MessagerModel mess = messagers.reversed.toList()[index];
                      final isMe = mess.createBy == GetStorageLocal.user?.email;
                      // final isMe = mess.createBy == SharedPrefs.user?.email;
                      final isRecall = mess.isRecalled ?? false;
                      return MessagesGroup(
                        mess,
                        isMe: isMe,
                        isRecall: isRecall,
                        onDeleteMess: (_) => controller.delete(mess.docId),
                        onEditMess: (_) => controller.editMess(context, mess),
                        onUnRecallMess: (_) => controller.unRecallMess(mess),
                        onRecallMess: (_) => controller.reCall(mess),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 24.0),
        child: TextField(
          controller: controller.messageController,
          focusNode: controller.messFocus,
          onTap: () => Timer(
            const Duration(milliseconds: 600),
            () => controller.scrollScreen(),
          ),
          style: const TextStyle(color: AppColor.orange),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.white,
            hintStyle: const TextStyle(
              color: Color(0xffB7B8BA),
              fontSize: 14.0,
            ),
            hintText: 'Messager here',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            suffixIcon: GestureDetector(
              onTap: controller.sendMessage,
              child: const Icon(Icons.send, color: Colors.brown),
            ),
          ),
        ),
      ),
    );
  }
}
