import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';

class ForumMessageInputSection extends StatelessWidget {
  ForumMessageInputSection({super.key});

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.image_outlined,
              size: 8 * 4,
            )),
        Expanded(
            child: CustomInput.text(
                context: context, controller: messageController, label: "Comment")),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send_rounded,
              size: 8 * 4,
            ))
      ],
    );
  }
}
