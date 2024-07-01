// ignore_for_file: prefer_const_constructors

import 'package:chat_app/screens/chat/views/chat_screen.dart';
import 'package:chat_app/utils/helper.dart';
import 'package:flutter/material.dart';

// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/constants/app_constant.dart';
import 'package:chat_app/providers/tab_controller_provider.dart';
import 'package:chat_app/tabs/home_tab.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController(initialPage: 0);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var tcp = context.watch<TabControllerProvider>();

    return PopScope(
      onPopInvoked: (didPop) {},
      child: Scaffold(
        bottomNavigationBar: _bottonNavigationBar(context, tcp),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          allowImplicitScrolling: false,
          controller: _pageController,
          children: tabScreens,
        ),
      ),
    );
  }

  List<Widget> tabScreens = [
    HomeScreen(),
    ChatScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  List<String> titleList = [
    "Chats",
    "AI Assistant",
    "Communities",
    "Calls",
  ];
  int _bottomNavIndex = 0;

  AnimatedBottomNavigationBar _bottonNavigationBar(
      BuildContext context, TabControllerProvider tcp) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: AppConstant.tabIconList.length,
      tabBuilder: (int index, bool isActive) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppConstant.tabIconList[index],
              size: 24,
              color: isActive
                  ? AppConstant.primaryTextColor
                  : AppConstant.secondaryTextColor,
            ),
            Text(
              titleList[index],
              style: TextStyle(
                color: isActive
                    ? AppConstant.primaryTextColor
                    : AppConstant.secondaryTextColor,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
              ),
            )
          ],
        );
      },
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.none,
      // notchSmoothness: NotchSmoothness.verySmoothEdge,
      // leftCornerRadius: 32,
      // rightCornerRadius: 32,

      onTap: (index) {
        setState(
          () => _bottomNavIndex = index,
        );
        index == 1
            ? Helper.toScreen(
                context,
                ChatScreen(),
              )
            : _pageController.jumpToPage(index);
      },
      //other params
    );
  }
}
