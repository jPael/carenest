import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/childcare_tips/feed_item.dart';
import 'package:smartguide_app/models/revamp/child_care_tips.dart';
import 'package:smartguide_app/services/laravel/child_care_tips_services.dart';

class FeedSection extends StatefulWidget {
  const FeedSection({super.key});

  @override
  State<FeedSection> createState() => _FeedSectionState();
}

class _FeedSectionState extends State<FeedSection> {
  late final List<ChildCareTips> data;

  bool isLoading = true;

  Future<void> fetchData() async {
    final d = await fetchAllChildCareTips();

    setState(() {
      data = d;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Column(
            children: [
              SizedBox.square(
                dimension: 8 * 3,
                child: CircularProgressIndicator(),
              )
            ],
          )
        : Column(
            children: [
              ...data.map((c) => FeedItem(data: c))

              // FeedItem(
              //   title: "How to Help Your Baby Sleep Through the Night.",
              // ),
              // FeedItem(
              //   title: "5 Foods to Boost Baby’s Nutrition.",
              // ),
              // FeedItem(title: "How to Help Your Baby Sleep Safely."),
            ],
          );
  }
}
