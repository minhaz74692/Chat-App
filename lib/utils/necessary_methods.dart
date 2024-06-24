import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NecessaryMethods {
  NecessaryMethods();

  static void showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static bool signUpValidation(
      String email, String password, String name, String phone) {
    if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
      showMessage('All Fields are empty');
      return false;
    } else if (email.isEmpty) {
      showMessage('Email is empty');
      return false;
    } else if (password.isEmpty) {
      showMessage('Password is empty');
      return false;
    } else if (name.isEmpty) {
      showMessage('Name is empty');
      return false;
    } else if (phone.isEmpty) {
      showMessage('Phone number is empty');
      return false;
    } else {
      return true;
    }
  }

  static showLoaderDialog({required BuildContext context, required String title}) {
    AlertDialog alert = AlertDialog(
      content: Builder(
        builder: (context) {
          return SizedBox(
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  margin: EdgeInsets.only(left: 7),
                  child: Text(title),
                ),
              ],
            ),
          );
        },
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
