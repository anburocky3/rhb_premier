import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:rhb_premier/Components/custom_button.dart';
import 'package:rhb_premier/Theme/colors.dart';

class DepositsPage extends StatefulWidget {
  @override
  _DepositsPageState createState() => _DepositsPageState();
}

class _DepositsPageState extends State<DepositsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textFieldBackground,
      appBar: AppBar(
        title: Text('locale.deposits!'),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: ListView(
            children: [
              CustomButton(
                onTap: () {
                  // Navigator.pushNamed(context, PageRoutes.makeADeposit);
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                textStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 18,
                    color: Theme.of(context).scaffoldBackgroundColor),
                label: 'locale.uploadDeposit',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'locale.pendingDeposits!',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Theme.of(context).hintColor, fontSize: 12),
                ),
              ),
              buildPendingDeposit(context),
              SizedBox(
                height: 16,
              ),
              buildPendingDeposit(context),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'locale.pastDeposited!',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Theme.of(context).hintColor, fontSize: 12),
                ),
              ),
              buildPendingDeposit(context, isPending: false)
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Container buildPendingDeposit(BuildContext context, {bool isPending = true}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            blurRadius: 1,
            spreadRadius: 0.001,
          )
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'locale.depositTo!' + '\n',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 12, color: Theme.of(context).hintColor)),
                TextSpan(
                    text: 'SB 1124 1354 3512',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(height: 1.4, fontSize: 16)),
              ])),
              Spacer(
                flex: 5,
              ),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'locale.amount!' + '\n',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 12, color: Theme.of(context).hintColor)),
                TextSpan(
                    text: '\$ 500.00',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(height: 1.4, fontSize: 16)),
              ])),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'locale.uploadedOn!' + '\n',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 12, color: Theme.of(context).hintColor)),
                TextSpan(
                    text: '10 June, 2019 11:49 am',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(height: 1.4, fontSize: 16)),
              ])),
              Spacer(
                flex: 5,
              ),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'locale.status!' + '\n',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 12, color: Theme.of(context).hintColor)),
                TextSpan(
                    text: isPending ? 'locale.pending' : 'locale.deposited',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        height: 1.4,
                        fontSize: 17,
                        color: isPending
                            ? secondaryColor
                            : Theme.of(context).primaryColor)),
              ])),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
