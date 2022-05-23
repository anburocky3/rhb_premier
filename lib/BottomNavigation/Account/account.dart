import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhb_premier/Routes/routes.dart';
import 'package:rhb_premier/helpers/PageLoader.dart';
import 'package:rhb_premier/models/LoginResponse.dart';
import 'package:rhb_premier/providers/AuthProvider.dart';
import 'package:rhb_premier/services/api.dart';
import 'package:rhb_premier/widgets/avatar.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class AccountOption {
  String? title;
  String? subtitle;
  Function onTap;

  AccountOption(this.title, this.subtitle, this.onTap);
}

class _AccountPageState extends State<AccountPage> {
  User _user = User();

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      getUserData();
    });
  }

  getUserData() async {
    final loader = PageLoader(context);
    loader.init();

    final currentUser = await ApiService().getCurrentUser();

    setState(() {
      _user = currentUser;
    });

    loader.complete();
  }

  @override
  Widget build(BuildContext context) {
    List<AccountOption> _accountOptions = [
      AccountOption('Terms & Conditions', 'Bank & App using terms & conditions',
          () {
        Navigator.pushNamed(context, PageRoutes.tnc);
      }),
      // AccountOption('FAQs', 'Frequently Asked Questions', () {
      //   Navigator.pushNamed(context, PageRoutes.faqsPage);
      // }),
      AccountOption(
          '24x7 Support', 'Get your problem solved with 24/7 support teams',
          () {
        Navigator.pushNamed(context, PageRoutes.supportPage);
      }),
      AccountOption('Logout', 'Logout from app', () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Logout?"),
                content: Text("Are you sure you want to logout?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final loader = PageLoader(context);
                      loader.init();

                      AuthProvider authProvider =
                          Provider.of<AuthProvider>(context, listen: false);
                      await authProvider.logout();

                      context.showSuccessBar(
                          content: Text('Successfully Logged out!'));
                      loader.complete();
                      Navigator.pop(context, true);
                    },
                    child: Text('Confirm'),
                  ),
                ],
              );
            });

        // Phoenix.rebirth(context);
      }),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Account Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, PageRoutes.profilePage);
                },
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                leading: FadedScaleAnimation(
                  RoundedAvatar(
                    image: _user.image,
                    height: 110,
                  ),
                ),
                title: Text(
                  "${_user.firstname ?? ''} ${_user.lastname ?? 'Loading...'}",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(
                          fontSize: 18,
                          color: Theme.of(context).scaffoldBackgroundColor)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'View Profile',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 14),
                ),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 12),
                shrinkWrap: true,
                itemCount: _accountOptions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        onTap: _accountOptions[index].onTap as void Function()?,
                        title: Text(
                          _accountOptions[index].title!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(_accountOptions[index].subtitle!),
                      ),
                      Divider(),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
