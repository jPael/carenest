import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartguide_app/components/mother/home/childcare_tips/feed_view_content_section.dart';
import 'package:smartguide_app/components/mother/home/childcare_tips/feed_view_title_section.dart';
import 'package:smartguide_app/models/revamp/child_care_tips.dart';

class ChildcareTipsFeedViewPage extends StatefulWidget {
  const ChildcareTipsFeedViewPage({super.key, required this.data});

  final ChildCareTips data;

  @override
  State<ChildcareTipsFeedViewPage> createState() => _ChildcareTipsFeedViewPageState();
}

class _ChildcareTipsFeedViewPageState extends State<ChildcareTipsFeedViewPage> {
  bool isFavorite = false;

  void handleBookmark() {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (!isFavorite) return;

    Fluttertoast.showToast(
      msg: "This post is added to you bookmark",
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      fontSize: 16,
      backgroundColor: Colors.grey[700],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: handleBookmark,
            icon: const Icon(Icons.bookmark_outline_rounded),
            isSelected: isFavorite,
            selectedIcon: Icon(
              Icons.bookmark,
              color: Colors.yellow[700],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8 * 3),
          child: Column(
            children: [
              FeedViewTitleSection(title: widget.data.title),
              const SizedBox(
                height: 8 * 3,
              ),
              FeedViewContentSection(
                data: widget.data,
              )
            ],
          ),
        ),
      ),
    );
  }
}
