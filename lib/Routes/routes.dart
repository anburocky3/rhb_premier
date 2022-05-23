import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhb_premier/Auth/Login/login_page.dart';
import 'package:rhb_premier/Auth/Verification/verification_page.dart';
import 'package:rhb_premier/BottomNavigation/Account/account.dart';
import 'package:rhb_premier/BottomNavigation/Account/faqs.dart';
import 'package:rhb_premier/BottomNavigation/Account/profile.dart';
import 'package:rhb_premier/BottomNavigation/Account/support.dart';
import 'package:rhb_premier/BottomNavigation/Account/tnc.dart';
import 'package:rhb_premier/BottomNavigation/Banking/Deposit/deposits.dart';
import 'package:rhb_premier/BottomNavigation/Banking/FundTransfer/fund_transfer.dart';
import 'package:rhb_premier/BottomNavigation/Banking/home.dart';
import 'package:rhb_premier/BottomNavigation/Transactions/transactions.dart';
import 'package:rhb_premier/BottomNavigation/app_navigation.dart';
import 'package:rhb_premier/providers/AuthProvider.dart';

class PageRoutes {
  static const String home = '/';
  static const String forceLogin = 'login';
  static const String homePage = 'home_page';
  static const String securityCode = 'security_code';
  static const String appNavigation = 'app_navigation';
  static const String fundTransfer = 'fund_transfer';
  static const String deposits = 'deposits';
  static const String profilePage = 'profile_page';
  static const String faqsPage = 'faq_page';
  static const String supportPage = 'support_page';
  static const String tnc = 'tnc';
  static const String accountPage = 'account_page';
  static const String transactionsPage = 'transactions_page';

  Map<String, WidgetBuilder> routes() {
    return {
      home: (context) {
        final authProvider = Provider.of<AuthProvider>(context);
        if (authProvider.isAuthenticated) {
          return AppNavigation();
        } else {
          return LoginPage();
        }
      },
      forceLogin: (context) => LoginPage(),
      securityCode: (context) =>
          VerificationPage(email: ModalRoute.of(context)?.settings.arguments),
      homePage: (context) => HomePage(),
      appNavigation: (context) => AppNavigation(),
      fundTransfer: (context) => FundTransfer(),
      deposits: (context) => DepositsPage(),
      profilePage: (context) => ProfilePage(),
      faqsPage: (context) => FAQPage(),
      supportPage: (context) => SupportPage(),
      tnc: (context) => TermsConditions(),
      accountPage: (context) => AccountPage(),
      transactionsPage: (context) => Transactions(),
    };
  }
}
