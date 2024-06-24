// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/constants/app_constant.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/screens/home.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/utils/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String profileImage = "";
  bool connection = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  AppConstant.splashIcon,
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              AppConstant.appTitle,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: AppConstant.scaffoldColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigate() async {
    final UserProvider ub = context.read<UserProvider>();
    SharedPreferences? sp = await SharedPreferences.getInstance();

    bool? isSignedIn = sp.getBool("isSignedIn");
    debugPrint(isSignedIn.toString());

    Future.delayed(const Duration(milliseconds: 1500)).then((value) async {
      ub.getUserData().then((value) async {
        if (isSignedIn == true) {
          Helper.nextScreenCloseOthers(context, Home());
        } else {
          Helper.nextScreenCloseOthers(context, LogIn());
        }
      });
    });
  }
}
