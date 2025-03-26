import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartguide_app/components/mother/home/forum/forum_create_post_form.dart';
import 'package:smartguide_app/components/mother/home/forum/forum_toolbar_section.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/section/custom_section_item.dart';
import 'package:smartguide_app/models/forum/forum.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/mother/forum/forum_post_page.dart';
import 'package:smartguide_app/services/forum_services.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key, required this.label});

  final String label;

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final ForumServices forumServices = ForumServices();

  void showPostButton(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.9, // 90% of screen height
            width: double.infinity,
            padding: const EdgeInsets.all(4 * 4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: ForumCreatePostForm());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48 + 8 * 2), // example height
          child: ForumToolbarSection(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showPostButton(context),
        label: Text("Create a post"),
        icon: Icon(Ionicons.pencil),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8 * 2),
          child: Column(
            spacing: 8 * 3,
            children: [
              StreamBuilder<Object>(
                  stream: forumServices.getForumStream(user.address!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10 * 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Something went wrong... please try again",
                              style: TextStyle(
                                  fontSize: 4 * 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[900]),
                            )
                          ],
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10 * 8.0),
                        child: Center(
                          child: Column(
                            spacing: 4 * 2,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              Text(
                                "Loading, please wait...",
                                style: TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    }

                    final List<Forum> forums = snapshot.data as List<Forum>;

                    // log(forums[0].replies.toString());

                    return CustomSection(
                      title: "Most recent posts",
                      children: forums
                          .map(
                            (forum) => CustomSectionItem(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForumPostPage(
                                            forum: forum,
                                            liked: true,
                                          ))),
                              title: forum.title,
                              email: forum.author!.email,
                              user: "${forum.author!.firstname} ${forum.author!.lastname}",
                              replyCount: 12,
                              date: (forum.createdAt as Timestamp).toDate(),
                              liked: true,
                            ),
                          )
                          .toList(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
