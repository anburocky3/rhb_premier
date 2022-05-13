import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:rhb_premier/Components/custom_button.dart';
import 'package:rhb_premier/Theme/colors.dart';


class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textFieldBackground,
      appBar: AppBar(
        elevation: 0,
        title: Text('Support'),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Spacer(),
                  Image(image: AssetImage('assets/logo.png'), width: 180),
                  // RichText(
                  //     text: TextSpan(
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodyText1!
                  //             .copyWith(
                  //                 color:
                  //                     Theme.of(context).scaffoldBackgroundColor,
                  //                 fontSize: 24),
                  //         children: <TextSpan>[
                  //       TextSpan(text: 'RGB '),
                  //       TextSpan(
                  //           text: 'Banking',
                  //           style: TextStyle(fontWeight: FontWeight.w300)),
                  //     ])),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "We're Here...",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 17),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Fragment Park, Near World Trade Building, Melbourne, Australia',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Theme.of(context).hintColor, fontSize: 15),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Connect us',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.mail,
                      color: secondaryColor,
                    ),
                    title: Text(
                      'info@rhbpb.com',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.mail,
                      color: secondaryColor,
                    ),
                    title: Text(
                      'customercare@rhbpb.com',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.mail,
                      color: secondaryColor,
                    ),
                    title: Text(
                      'offshoreaccounts@rhbpb.com',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.web,
                      color: secondaryColor,
                    ),
                    title: Text(
                      'rhbgroup.com',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Write us directly',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mail,
                        size: 18,
                        color: secondaryColor,
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.35,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Your Message',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: CustomButton(
                label: 'Submit',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
