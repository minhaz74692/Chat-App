// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/screens/home.dart';
import 'package:chat_app/screens/signup.dart';
import 'package:chat_app/utils/helper.dart';
import 'package:chat_app/utils/necessary_methods.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:chat_app/widgets/title_widget.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool showPassword = true;
  late IconData lockIcon = Icons.visibility;
  TextEditingController email = TextEditingController(text: 'minhaz@gmail.com');
  TextEditingController password = TextEditingController(text: '12345678');

  handleSignInwithemailPassword() async {
    final FirebaseAuthProvider sb =
        Provider.of<FirebaseAuthProvider>(context, listen: false);
    var ub = context.read<UserProvider>();
    SharedPreferences sp = await SharedPreferences.getInstance();
    NecessaryMethods.showLoaderDialog(context: context, title: 'Loading...');

    try {
      await sb
          .signInwithEmailPassword(email.text, password.text)
          .then((_) async {
        if (sb.hasError == false) {
          ub
              .saveUserData(
                  UserModel(
                    userId: 'ksdf',
                    userName: 'userName',
                    emailId: email.text,
                    phone: 'phone',
                  ),
                  'email')
              .then((_) async {
            await sp.setBool("isSignedIn", true);
            Helper.nextScreenCloseOthers(
              context,
              Home(),
            );
          });
        } else {
          NecessaryMethods.showMessage(sb.errorCode.toString());
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              TitleWidget(
                title: 'Log In',
                subTitle: 'Welcome to the Whatsapp Clone',
              ),
              SizedBox(
                height: 45,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: handleSignInwithemailPassword,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                    hintText: 'E-mail'),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: password,
                obscureText: showPassword,
                onEditingComplete: handleSignInwithemailPassword,
                decoration: InputDecoration(
                    suffixIcon: CupertinoButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                          lockIcon = lockIcon == Icons.visibility
                              ? Icons.visibility_off
                              : Icons.visibility;
                        });
                      },
                      child: Icon(
                        lockIcon,
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                    ),
                    hintText: 'Password'),
              ),
              SizedBox(height: 35),
              PrimaryButton(
                title: 'Log In',
                onPressed: handleSignInwithemailPassword,
              ),
              // CustomRoundedLoadingButton2(
              //   doSomething: () async {
              //     handleSignInwithemailPassword;
              //   },
              //   title: 'Log In',
              // ),
              SizedBox(height: 18),
              Center(child: Text('Do not have an account?')),
              SizedBox(height: 0),
              Center(
                child: CupertinoButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Helper.toScreen(context, SignUp());
                  },
                  child: Text(
                    'create account',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
