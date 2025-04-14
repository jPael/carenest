import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/forum/forum.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/services/auth_services.dart';

class ForumCreatePostForm extends StatefulWidget {
  const ForumCreatePostForm({super.key});

  @override
  State<ForumCreatePostForm> createState() => _ForumCreatePostFormState();
}

class _ForumCreatePostFormState extends State<ForumCreatePostForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPosting = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final auth = AuthServices().auth;

  Future<void> handlePost() async {
    setState(() {
      isPosting = true;
    });

    final user = context.read<User>();

    final Forum forum = Forum(
      title: titleController.text,
      content: contentController.text,
      authorId: user.uid!,
      barangay: user.address!,
    );

    final Map<String, dynamic> res = await forum.post();

    if (!mounted) return;
    if (res["success"]) {
      showSuccessMessage(context: context, message: "Posted successfully");
    } else {
      showErrorMessage(context: context, message: res["message"]);
    }

    Navigator.pop(context);

    setState(() {
      isPosting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Create a post",
      headerSpacing: 0,
      children: [
        CustomForm(
          actions: [
            CustomButton(
              onPress: handlePost,
              label: "Post",
              isLoading: isPosting,
              icon: const Icon(Ionicons.send),
              radius: 3,
            )
          ],
          children: [
            CustomInput.text(context: context, controller: titleController, label: "Title"),
            const SizedBox(
              height: 4 * 4,
            ),
            CustomInput.text(
                context: context,
                controller: contentController,
                label: "Content",
                minLines: 5,
                maxLines: 10),
          ],
        )
      ],
    );
  }
}
