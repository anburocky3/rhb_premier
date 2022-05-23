import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:rhb_premier/Routes/routes.dart';
import 'package:rhb_premier/Theme/colors.dart';
import 'package:rhb_premier/helpers/PageLoader.dart';
import 'package:rhb_premier/helpers/global.dart';
import 'package:rhb_premier/models/LoginResponse.dart';
import 'package:rhb_premier/services/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Option {
  String image;
  String? title;
  Function onTap;

  Option(this.image, this.title, this.onTap);
}

class _HomePageState extends State<HomePage> {
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
    List<Option> options = [
      Option('assets/icons/ic_account.png', 'Account', () {
        // Navigator.pushNamed(context, PageRoutes.accountPage);
        Navigator.pushNamed(context, PageRoutes.profilePage);
      }),
      Option('assets/icons/ic_fund transfer.png', 'Fund Transfer', () {
        Navigator.pushNamed(context, PageRoutes.fundTransfer);
      }),
      Option('assets/icons/ic_statement.png', 'Statement', () {
        Navigator.pushNamed(context, PageRoutes.transactionsPage);
      }),
      Option('assets/icons/ic_loan.png', 'Loans', () {
        // Navigator.pushNamed(context, PageRoutes.loansPage);
      }),
      Option('assets/icons/ic_deposite.png', 'Deposits', () {
        Navigator.pushNamed(context, PageRoutes.deposits);
      }),
      Option('assets/icons/ic_more.png', 'More', () {
        Navigator.pushNamed(context, PageRoutes.accountPage);
      }),
    ];
    return Builder(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
              height: 32,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                            height: 160,
                            child: FadedScaleAnimation(
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: AssetImage('assets/bg.png'),
                                      fit: BoxFit.fill),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${_user.firstname ?? ''} ${_user.lastname ?? ''} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                              color: textFieldBackground,
                                              fontSize: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0),
                                      child: Text(
                                        "Account No: ${_user.accountNumber ?? ''}",
                                        style: TextStyle(
                                            height: 1.4,
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(
                                          "Balance: ${GlobalHelper.formatAmount(_user.balance ?? '00.00')}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  height: 1.4)),
                                    ),
                                    Spacer(),
                                    Text(
                                      'Statement',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 20),
                          itemCount: options.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: options[index].onTap as void Function()?,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  index <= 2
                                      ? Divider(
                                          indent: 25,
                                          endIndent: 25,
                                        )
                                      : SizedBox.shrink(),
                                  FadedScaleAnimation(
                                    Image.asset(
                                      options[index].image,
                                      scale: 3,
                                    ),
                                  ),
                                  Text(options[index].title!),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Divider(
                                    indent: 25,
                                    endIndent: 25,
                                  ),
                                ],
                              ),
                            );
                          }),
                      FadedScaleAnimation(
                        Image.asset('assets/offers/offer1.jpg'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
