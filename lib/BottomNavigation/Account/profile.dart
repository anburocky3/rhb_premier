import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:rhb_premier/Theme/colors.dart';
import 'package:rhb_premier/widgets/avatar.dart';

import '../../models/LoginResponse.dart';
import '../../sharedPreferences/Prefs.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User _user = User();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    User? newUser = await Prefs.userData;

    setState(() {
      _user = newUser!;
    });

    // print('userInfo: ${_user.firstname}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Profile'),
      ),
      body: FadedSlideAnimation(
        ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).primaryColor,
                ),
                PositionedDirectional(
                  start: MediaQuery.of(context).size.width / 2.75,
                  // end: 0,
                  top: 40,
                  child: FadedScaleAnimation(
                    RoundedAvatar(image: _user.image, height: 110),
                  ),
                ),
                PositionedDirectional(
                    top: 40,
                    start: MediaQuery.of(context).size.width / 1.75,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: secondaryColor,
                      child: Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  buildTextField(context, 'Full Name',
                      '${_user.firstname} ${_user.lastname}',
                      readOnly: true),
                  buildTextField(context, 'Username', _user.username!,
                      readOnly: true),
                  buildTextField(context, 'Email Address', _user.email!,
                      readOnly: true),
                  buildTextField(
                      context, 'Account Number', _user.accountNumber!,
                      readOnly: true),
                ],
              ),
            ),
            SizedBox(
              height: 90,
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            //   child: CustomButton(
            //     label: 'Update Profile',
            //   ),
            // )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Widget buildTextField(context, String? label, String initialValue,
      {bool? readOnly, int? maxLines}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16),
        initialValue: initialValue,
        readOnly: readOnly ?? false,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
