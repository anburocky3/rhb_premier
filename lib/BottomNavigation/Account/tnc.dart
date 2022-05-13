import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16),
          child: ListView(
            children: [
              Text(
                '''
Dear customers,

To ensure that you are loading the latest Terms and Conditions, we recommend that you clear your cache regularly. If you are unsure how to do so,

Restrictions on Use of RHB Online Banking/RHB Mobile Banking

14.47 As a condition of your permitted use of the RHB Online Banking and/or the RHB Mobile Banking Application, you undertake that you will not use the Website/the RHB Online Banking and/or the RHB Mobile Banking Application (or any service, information or product thereunder):

i. for any illegal or unlawful purpose or where otherwise prohibited under law;
ii. Where prohibited by these Terms and Conditions; or
iii. In any manner which could damage, disable, overburden, corrupt or impair the Website or the hardware or application and software system, security protocols, information/service provider networks or other operations or interfere with any party's use and enjoyment of the Website.

14.48  You shall not attempt to gain unauthorised access to any account(s) or any hardware and software system, security protocols, information/service provider networks or other operations connected to the Website/the RHB Online Banking and/or the RHB Mobile Banking Application, through hacking, password mining or any other means.

14.49 You shall not obtain or attempt to obtain any materials or information through any means not intentionally made available through the Website/the RHB Online Banking and/or the RHB Mobile Banking Application.

14.50 You shall not modify, copy, distribute, transmit, use or otherwise deal with any of the products, services, information or the Content of the Website/the RHB Online Banking and/or the RHB Mobile Banking Application without obtaining our prior written approval unless expressly allowed under these Terms and Conditions. Further, you shall not post, send or transmit any unauthorised Content on to or through the Website/the RHB Online Banking and/or the RHB Mobile Banking Application including Content that:

i.	is unlawful, vulgar, obscene, defamatory, in breach of privacy, abusive or otherwise objectionable;
ii.	"junkmail", "spam", "chain letters" or any other form of unauthorised materials; and
       iii.         Contains software viruses or any file or program that may interrupt, disable, overburden, corrupt or impair the Website/the RHB Online Banking and/or the RHB Mobile Banking Application or the hardware and software system, security protocols, information/service provider networks or other operations.

                ''',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
