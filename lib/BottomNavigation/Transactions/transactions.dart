import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhb_premier/Theme/colors.dart';
import 'package:rhb_premier/helpers/global.dart';
import 'package:rhb_premier/models/LoginResponse.dart';
import 'package:rhb_premier/models/Transaction.dart';
import 'package:rhb_premier/providers/AuthProvider.dart';
import 'package:rhb_premier/providers/TransactionProvider.dart';
import 'package:rhb_premier/services/api.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  void initState() {
    super.initState();

    getTransaction();
  }

  void getTransaction() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    var response = await ApiService(authProvider.getToken).fetchTransactions();
    transactionProvider.setTransactionList(response);

    // await Future.delayed(Duration(milliseconds: 150));
    // context.showToast('Unauthenticated, so logging out!');
    // AuthProvider().logout();
    // print("transaction-api: ${authProvider.getToken}");
    // print("transaction-api: ${jsonEncode(response)}");
  }

  @override
  Widget build(BuildContext context) {
    String userData = Provider.of<AuthProvider>(context).getUserData;
    User user = User.fromJson(jsonDecode(userData));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Transactions'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  FadedScaleAnimation(
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: AssetImage('assets/bg.png'),
                            fit: BoxFit.fill),
                      ),
                      child: Row(
                        children: [
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text:
                                    "${user.firstname} ${user.lastname}" + '\n',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: textFieldBackground,
                                        fontSize: 12)),
                            TextSpan(
                                text: user.accountNumber,
                                style: TextStyle(
                                    height: 1.4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor)
                                // style: Theme.of(context)
                                //     .textTheme
                                //     .headline6!
                                //     .copyWith(
                                //         color: Theme.of(context)
                                //             .scaffoldBackgroundColor,
                                //         height: 1.4),
                                ),
                          ])),
                          Spacer(),
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: 'Available Balance' + '\n',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: textFieldBackground,
                                        fontSize: 12)),
                            TextSpan(
                                text: GlobalHelper.formatAmount(
                                    user.balance ?? "0"),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        height: 1.4)),
                          ])),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
              child: Text(
                'Recent Transactions',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Theme.of(context).hintColor, fontSize: 12),
              ),
            ),
            Consumer<TransactionProvider>(
              builder: (_, provider, __) => provider.isLoaded
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.transactionList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Transaction transaction =
                            provider.transactionList[index];
                        return ListTile(
                          title: Text(
                            transaction.details!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            GlobalHelper.toHumanReadable(
                                    transaction.createdAt!)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Theme.of(context).hintColor),
                          ),
                          trailing: Text(
                            GlobalHelper.formatAmount(transaction.amount!),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: (transaction.trxType == '-')
                                        ? redColor
                                        : secondaryColor),
                          ),
                          onTap: () {},
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
