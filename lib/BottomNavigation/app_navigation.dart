import 'package:flutter/material.dart';
import 'package:rhb_premier/Theme/colors.dart';

import 'Account/account.dart';
import 'Banking/home.dart';
import 'Transactions/transactions.dart';

class AppNavigation extends StatefulWidget {
  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    Transactions(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> _items = [
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/footer icons/ic_banking.png')),
        activeIcon:
        ImageIcon(AssetImage('assets/footer icons/ic_banking_act.png')),
        label: 'Banking',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/footer icons/ic_transaction.png'),
        ),
        activeIcon:
        ImageIcon(AssetImage('assets/footer icons/ic_transaction_act.png')),
        label: 'Transaction',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/footer icons/ic_accounts.png'),
        ),
        activeIcon:
        ImageIcon(AssetImage('assets/footer icons/ic_accounts_act.png')),
        label: 'Account',
      ),
    ];
    return Scaffold(
      backgroundColor: blackColor,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: textFieldBackground,
        backgroundColor: blackColor,
        items: _items,
        currentIndex: _currentIndex,
        elevation: 15,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
