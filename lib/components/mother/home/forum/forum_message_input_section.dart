import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/models/forum/forum.dart';
import 'package:smartguide_app/models/forum/reply.dart';
import 'package:smartguide_app/models/user.dart';

class ForumMessageInputSection extends StatefulWidget {
  const ForumMessageInputSection({super.key, required this.forum});

  final Forum forum;

  @override
  State<ForumMessageInputSection> createState() => _ForumMessageInputSectionState();
}

class _ForumMessageInputSectionState extends State<ForumMessageInputSection> {
  final TextEditingController messageController = TextEditingController();

  bool isLoading = false;

  Future<void> handleReply() async {
    setState(() {
      isLoading = true;
    });

    final user = context.read<User>();

    final reply =
        Reply(content: messageController.text, authorId: user.uid!, forumId: widget.forum.docId!);

    await reply.post();
    messageController.clear();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0 * 2, vertical: 8.0),
      child: Row(
        children: [
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.image_outlined,
          //       size: 8 * 4,
          //     )),
          Expanded(
              child: CustomInput.text(
                  context: context, controller: messageController, label: "Comment")),
          isLoading
              ? const SizedBox.square(
                  dimension: 8.0 * 7,
                  child: Padding(
                    padding: EdgeInsets.all(2 * 8.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : IconButton(
                  onPressed: handleReply,
                  icon: Icon(
                    Icons.send_rounded,
                    size: 8 * 4,
                  ))
        ],
      ),
    );
  }
}
