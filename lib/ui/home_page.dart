// ignore_for_file: prefer_const_constructors
import 'package:animations/animations.dart';
import 'package:contact_app/ui/contacts_page.dart';
import 'package:contact_app/ui/favorite_page.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  List pages = [
    {
      'page': ContactsPage(),
      'index': 0,
    },
    {
      'page': FavoritesPage(),
      'index': 1,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 70,
        backgroundColor: AppColors.primaryColorBlack,
        // centerTitle: true,
        title: Text(
          _page == 0 ? "Contact List" : "Favorite List",
          style: TextStyle(
              color: AppColors.primaryColorWhite, fontWeight: FontWeight.w500),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/contact.png",
                height: 35,
                width: 35,
                fit: BoxFit.cover,
                color: _page == 0
                    ? AppColors.primaryColorBlack
                    : AppColors.lightGrey),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/favorite.png",
              height: 35,
              width: 35,
              fit: BoxFit.cover,
              color: _page == 1
                  ? AppColors.primaryColorBlack
                  : AppColors.lightGrey,
            ),
            label: 'Favorite',
          ),
        ],
        currentIndex: _page,
        selectedItemColor: AppColors.primaryColorBlack,
        backgroundColor: AppColors.primaryColorWhite,
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        onTap: navigationTapped,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        selectedIconTheme: IconThemeData(size: 20),
        unselectedIconTheme: IconThemeData(size: 20),
        unselectedLabelStyle: TextStyle(
            fontSize: 14,
            color: AppColors.lightGrey,
            fontWeight: FontWeight.w500),
        selectedLabelStyle: TextStyle(
            fontSize: 16,
            color: AppColors.primaryColorBlack,
            fontWeight: FontWeight.w500),
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pages[_page]['page'],
      ),
    );
  }

  void navigationTapped(int page) {
    setState(() {
      _page = page;
    });
  }
}
