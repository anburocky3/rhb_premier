import'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';

class FundTransfer extends StatefulWidget {
  @override
  _FundTransferState createState() => _FundTransferState();
}

class Trans {
  String? title;
  String? subtitle;
  Function onTap;
  Trans(this.title, this.subtitle, this.onTap);
}

class _FundTransferState extends State<FundTransfer> {
  @override
  Widget build(BuildContext context) {
    List<Trans> transaction = [
      Trans('Fund Transfer Own Account', 'Within RHB Bank', () {
        // Navigator.pushNamed(context, PageRoutes.fundTransferWithinBank);
      }),
      Trans('Fund Transfer Other Account', 'Within RHB Bank Other Account', () {}),
      Trans('DuitNow Pay', 'Quick Pay to Account by Bank', () {
        // Navigator.pushNamed(context, PageRoutes.impsQuickTransferMode);
      }),
      Trans('IBG Transfer (Real-Time)', 'Transfer to Other Bank Account', () {}),
      Trans('FTT- Foreign Telegraphic Transfer', 'International Wire Transfer - SWIFT Mode', () {}),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Fund Transfer'),
      ),
      body: FadedSlideAnimation(
        ListView.builder(
            itemCount: transaction.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: transaction[index].onTap as void Function()?,
                  leading: Image.asset(
                    'assets/icons/ic_transfer.png',
                    scale: 3,
                  ),
                  title: Text(transaction[index].title!),
                  subtitle: Text(transaction[index].subtitle!),
                ),
              );
            }),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
