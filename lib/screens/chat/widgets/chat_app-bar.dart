// ignore_for_file: prefer_const_constructors

import 'package:chat_app/screens/apps_colors.dart';
import 'package:chat_app/screens/text.style.dart';
import 'package:chat_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatScreenAppBar extends StatelessWidget {
  const ChatScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Helper.back(context);
            },
            icon: Icon(Icons.close),
          ),
          // Container(
          //   height: 44,
          //   width: 44,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(44),
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(44),
          //     child: Image.asset(
          //       "assets/png/avatar1.png",
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "AI Assistant- Gemini",
                style: interStyle16_600,
              ),
              // SizedBox(
              //   height: 4,
              // ),
              // Text(
              //   "Online",
              //   style:
              //       interStyle12_400.copyWith(color: AppColors.inactiveColor),
              // ),
            ],
          ),
          Spacer(),
          // GestureDetector(
          //   onTap: () {
          //     Fluttertoast.showToast(msg: "Need to configure call system");
          //   },
          //   child: Container(
          //     width: 21,
          //     height: 21,
          //     decoration:
          //         BoxDecoration(borderRadius: BorderRadius.circular(21)),
          //     child: Icon(
          //       Icons.phone,
          //       color: Color(0xFF008951),
          //       size: 21,
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              Fluttertoast.showToast(msg: "Need to configure ");
            },
            child: Container(
              width: 21,
              height: 21,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(21)),
              child: Icon(
                Icons.info_outline,
                color: Color(0xFF008951),
                size: 21,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
