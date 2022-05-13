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
      Trans('Fund Transfer', 'Within Bank', () {
        // Navigator.pushNamed(context, PageRoutes.fundTransferWithinBank);
      }),
      Trans('Fund Transfer', 'To Other Bank', () {}),
      Trans('IMPS', 'Quick transfer mode', () {
        // Navigator.pushNamed(context, PageRoutes.impsQuickTransferMode);
      }),
      Trans('NEFT', 'Transfer Money', () {}),
      Trans('RTGS', 'Easiest mode to transfer money', () {}),
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
