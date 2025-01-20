import 'package:chat_app/models/course_model.dart';
import 'package:chat_app/pages/course_detail/course_detail_page.dart';
import 'package:chat_app/pages/favorite/widget/favorite_item.dart';
import 'package:chat_app/resource/img/app_images.dart';
import 'package:chat_app/resource/themes/app_colors.dart';
import 'package:chat_app/resource/themes/app_style.dart';
import 'package:chat_app/services/local/shared_prefs.dart';
import 'package:chat_app/services/remote/course_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  CourseServices courseServices = CourseServices();
  List<CourseModel> favoriteList = [];

  final Stream<QuerySnapshot> courseStream = FirebaseFirestore.instance
      .collection('courses')
      .orderBy('id', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgColor,
        body: StreamBuilder(
            stream: courseStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColor.blue),
                );
              }
              favoriteList = (snapshot.data?.docs
                          .map((e) => CourseModel.fromJson(
                              e.data() as Map<String, dynamic>)
                            ..docId = e.id)
                          .toList() ??
                      [])
                  .where((e) =>
                      (e.favorites ?? []).contains(SharedPrefs.user?.email))
                  .toList();

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  Text(
                    'Favorite',
                    style: AppStyles.STYLE_14_BOLD
                        .copyWith(color: AppColor.textColor),
                  ),
                  const SizedBox(height: 10.0),
                  favoriteList.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 100.0),
                            SvgPicture.asset(
                              AppImages.imageOnBoarding2,
                              height: 200.0,
                              width: 200.0,
                              fit: BoxFit.contain,
                            ),
                          ],
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: favoriteList.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 20.0),
                          itemBuilder: (context, idx) {
                            final course = favoriteList[idx];
                            return FavoriteItem(
                              course,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CourseDetailPage(course.docId ?? ""),
                                ),
                              ),
                            );
                          },
                        )
                ],
              );
            }));
  }
}
