// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/screens/home.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/utils/helper.dart';
import 'package:chat_app/utils/necessary_methods.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:chat_app/widgets/title_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showPassword = true;
  late IconData lockIcon = Icons.visibility;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  Future<bool> addUserToFirestore(UserModel userModel) async {
    final firestore = FirebaseFirestore.instance;

    try {
      final docRef =
          await firestore.collection('users').add(userModel.toFirestore());
      userModel.userId = docRef.id;

      await docRef.update({'user_id': userModel.userId});
      print('User added to Firestore with ID: ${userModel.userId}');
      return true;
    } catch (e) {
      print('Error adding User to Firestore: $e');
      return false;
    }
  }

  handleSignUpwithemailPassword() async {
    final FirebaseAuthProvider authProvider =
        Provider.of<FirebaseAuthProvider>(context, listen: false);
    var ub = context.read<UserProvider>();
    SharedPreferences? sp = await SharedPreferences.getInstance();

    NecessaryMethods.showLoaderDialog(context: context, title: 'Loading...');
    await authProvider
        .signUpwithEmailPassword(name.text, email.text, password.text)
        .then((value) async {
      await addUserToFirestore(
        UserModel(
          userName: name.text,
          emailId: email.text,
          phone: phone.text,
        ),
      );
      await sp.setBool("isSignedIn", true);
    }).then((_) async {
      if (authProvider.hasError == false) {
        ub
            .saveUserData(
                UserModel(
                  userName: name.text,
                  emailId: email.text,
                  phone: phone.text,
                ),
                'email')
            .then((_) {
          Helper.toScreen(
            context,
            Home(),
          );
        });
      } else {
        debugPrint(authProvider.errorCode.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TitleWidget(
                    title: 'Create an account',
                    subTitle: 'Have a good experience with Whatsapp clone',
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  TextFormField(
                    focusNode: nameFocus,
                    controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline,
                        ),
                        hintText: 'Full Name'),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: email,
                    focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                        hintText: 'E-mail'),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: phone,
                    focusNode: phoneFocus,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                        ),
                        hintText: 'Phone Number'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: password,
                    focusNode: passwordFocus,
                    obscureText: showPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        // isDense: true,
                        // filled: true,
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
                      title: 'Sign Up',
                      onPressed: () async {
                        bool isValid = NecessaryMethods.signUpValidation(
                            email.text, password.text, name.text, phone.text);
                        if (isValid) {
                          handleSignUpwithemailPassword();
                        }
                      }),
                  SizedBox(height: 18),
                  Center(child: Text('I have already an account?')),
                  SizedBox(height: 0),
                  Center(
                    child: CupertinoButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Helper.toScreen(context, LogIn());
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
