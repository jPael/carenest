import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/services/image_services.dart';

class ProfileUserSection extends StatefulWidget {
  const ProfileUserSection({super.key, required this.firstname, required this.email});

  final String firstname;
  final String email;

  @override
  State<ProfileUserSection> createState() => _ProfileUserSectionState();
}

class _ProfileUserSectionState extends State<ProfileUserSection> {
  Uint8List? profileImage;
  bool updatingProfile = false;

  void handleLogout() {
    FirebaseAuth.instance.signOut();
  }

  void selectImage() async {
    // setState(() {
    //   updatingProfile = !updatingProfile;
    // });

    // await Future.delayed(Duration(seconds: 3));

    // setState(() {
    //   updatingProfile = !updatingProfile;
    // });

    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      profileImage = img;
    });
  }

  //TODO: enable user to upload an avatar. for now, we can't because i only have free firebase account

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8 * 3, right: 8 * 3, top: 8 * 8, bottom: 8 * 4),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Row(
        spacing: 8 * 2,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: CircleAvatar(
                  foregroundImage: NetworkImage("https://i.pravatar.cc/200?u=${widget.email}"),
                  backgroundImage: AssetImage("lib/assets/images/profile_fallback.png"),
                ),
              ),
              // !updatingProfile
              //     ? Positioned(
              //         child: IconButton(
              //             iconSize: 4 * 8,
              //             tooltip: "Edit",
              //             onPressed: selectImage,
              //             icon: Icon(Icons.edit)))
              //     : Positioned(child: CircularProgressIndicator()),
            ],
          ),
          Expanded(
            child: Text(
              "Hi ${widget.firstname}",
              style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
          CustomButton.ghost(
              context: context,
              onPressed: handleLogout,
              label: "Log out",
              horizontalPadding: 1.5,
              icon: Icon(Ionicons.log_out))
        ],
      ),
    );
  }
}
