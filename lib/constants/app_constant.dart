import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/providers/tab_controller_provider.dart';

class AppConstant {
  static String appTitle = "ChatBox";
  static String splashIcon = "assets/images/icon.jpg";
  static String appIcon = "assets/images/icon.jpg";
  static String metaIcon = "assets/images/metaIcon.png";
  static String avator1 = "assets/images/avatar1.png";
  static String avator2 = "assets/images/avatar2.jpg";
  static Color primaryColor = const Color(0xFF27CA42);
  static Color scaffoldColor = Colors.white;
  static Color primaryTextColor = const Color(0xFF0A141B);
  static Color secondaryTextColor =const Color.fromARGB(255, 86, 94, 100);
  static Color dividerColor = const Color.fromARGB(255, 226, 222, 222);

  static List<IconData> tabIconList = [
    Icons.message,
    Icons.change_circle_outlined,
    Icons.groups_2_outlined,
    Icons.phone_outlined,
  ];
  static List<String> tabTitles = [
    "Chats",
    "Updates",
    "Communities",
    "Calls",
  ];

  static hideNavBar(bool status, BuildContext context) {
    var tcp = context.read<TabControllerProvider>();
    Future.microtask(() => tcp.setHideNavBar(status));
  }
}
